/*
 * File:   main.c
 * Author: student
 *
 * Created on 01 February 2019, 11:24
 */


#include <xc.h>
#pragma config FOSC=HS,WDTE=OFF,PWRTE=OFF,MCLRE=ON,CP=OFF,CPD=OFF,BOREN=OFF,CLKOUTEN=OFF
#pragma config IESO=OFF,FCMEN=OFF,WRT=OFF,VCAPEN=OFF,PLLEN=OFF,STVREN=OFF,LVP=OFF
#define _XTAL_FREQ 8000000

//definisanje makrostrukture
#define check_bit(x, b) (!!((x)&(1<<(b))))

/*void interrupt prekid(void){
    int brojac=0;
    float vrijeme=0;
    while(PORTDbits.RD1==1){
        brojac++;
    }
    if (brojac!=0)
        vrijeme=(3*(brojac-1)+2)*0.5*0.000001;
    PORTDbits.RD2=0;
    
    INTCONbits.INTF=0;
    return;
}*/
/*float vrijeme(){
    float vr=0;
    int brojac=0;
    //while(PORTDbits.RD1==1){}
    while(PORTDbits.RD1==0){
    }
    while(PORTDbits.RD1==1){
    brojac++;
    }
    if (brojac!=0)
    vr=(3*(brojac-1)+2)*0.5*0.000001;
    PORTDbits.RD2=0;
    return vr;
}*/

float udaljenost(void){
    TMR1ON = 1;
    TMR1L=TMR1H=0;
    //while(!(check_bit(*port_echo, pin_echo));
    while(!(PORTDbits.RD4));
    TMR1ON=0;
    TMR1L=TMR1H=0;
    TMR1ON = 1;
    while(PORTDbits.RD4);
    //TMR1H<<8 siftan registar za 8 mjesta
    float d = (TMR1L |(TMR1H<<8)) /588.23 ;
    if(d>50)
        d=50;
    return d;
}

void init_port(){
    ANSELD=0x00;
    TRISD=0x10;
    
    ANSELB=0x00;
    TRISB=0x00;
    
    
    TRISC = 0x00;
    LATC=0x00;
    return;
}

void init_serial()
{
	//BRGH=1;  // High Baud Rate
	//SPBRG=51; // Za 9600 na Fosc=8MHz
	SYNC=0;	// Asinhrona komunikacija
    BRG16=0;
    BRGH=0;
    SPBRGL=12;
	SPEN=1;	// Aktiviranje serijskog porta
	RCIE=0; // Onemogucavanje interrupta na serijskom portu
	CREN=0; // Ukljucivanje/iskljucivanje prijemnika
    return;
}

/*ukoliko zelimo vrsiti citanje/primanje podataka potrebno postaviti
 CREN = 1
SYNC = 0
SPEN = 1
 */

/*void cekanje(int t){
    char b=0;
    float br= t/0.032768;
    b=br;
    while(b>0){
        TMR0=0x04;
        while(!(INTCONbits.TMR0IF)){}
        b--;
        INTCONbits.TMR0IF=0;
     }
    return;
}*/

void main(void) {
    init_port();
    init_serial();
    //inicijalizacija modula tajmera 1
    T1CON = 0x10;
    TXEN = 1;
    
    while(1){
        PORTDbits.RD3=1;
        __delay_us(10);
        PORTDbits.RD3=0;
        
        float d = udaljenost();
        LATB=d;
    //slanje izracunate udaljenosti
        int brojac=0;
        while(brojac!=64){
         PORTDbits.RD3=1;
        __delay_us(10);
        PORTDbits.RD3=0;
        
        float d = udaljenost();
        LATB=d;
            PORTDbits.RD1=1;
            __delay_ms(150);
            PORTDbits.RD1=0;
            __delay_ms(150);
            PORTDbits.RD5=1;
            __delay_ms(150);
            PORTDbits.RD5=0;
            __delay_ms(150);
            PORTDbits.RD2=1;
            __delay_ms(150);
            PORTDbits.RD2=0;
            __delay_ms(150);
            PORTDbits.RD6=1;
            __delay_ms(200);
            PORTDbits.RD6=0;
            __delay_ms(150);
            brojac=brojac+4;
            TXREG = (unsigned char) d;
            while(!TXIF); 
            TXREG = (d - (unsigned char) d)*10;
            while(!TXIF); 
            TXREG = 'A';
            while(!TXIF);
            //__delay_ms(800);
        }
        TXREG = 'B';
        while(!TXIF);
        
        while(brojac!=0){
            PORTDbits.RD3=1;
        __delay_us(10);
        PORTDbits.RD3=0;
        
        float d = udaljenost();
        LATB=d;
            PORTDbits.RD6=1;
            __delay_ms(150);
            PORTDbits.RD6=0;
            __delay_ms(150);
            PORTDbits.RD2=1;
            __delay_ms(150);
            PORTDbits.RD2=0;
            __delay_ms(150);
            PORTDbits.RD5=1;
            __delay_ms(150);
            PORTDbits.RD5=0;
            __delay_ms(150);
            PORTDbits.RD1=1;
            __delay_ms(150);
            PORTDbits.RD1=0;
            __delay_ms(150);
            brojac=brojac-4;
            TXREG = (unsigned char) d;
            while(!TXIF); 
            TXREG = (d - (unsigned char) d)*10;
            while(!TXIF); 
            TXREG = 'A';
            while(!TXIF);
            //__delay_ms(800);
        }
        TXREG = 'B';
        while(!TXIF);
            
            
    }
    return;
}

/*citanje podataka 
 if(RCIE && RCIF) {
        reader = RCREG;
        if(reader == '#') sendData = 1;
        // spusti roletne
       
    }*/