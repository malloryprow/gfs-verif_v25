
      SUBROUTINE SETPNQ

C$$$  SUBPROGRAM DOCUMENTATION BLOCK                                    
C                .      .    .                                       .  
C SUBPROGRAM:    SETPNQ      SET PRESSURE LEVELS, C1, E1, AND Q-VALUES  
C   PRGMMR: STACKPOLE        ORG: W/NP12    DATE: 96-05-06
C                                                                       
C ABSTRACT:  ESTABLISHES THE DESIRED PRESSURE LEVELS, THE MANDATORY     
C   LEVEL NUMBERS OF SAID PRESSURE AND IT ALSO PUTS AWAY Q VALUES 
C   FOR DESIRED VARIABLES.                   
C                                                                       
C PROGRAM HISTORY LOG:                                                  
C   76-??-??  STACKPOLE                                                 
C   89-01-25  VLCEK       CONVERT FROM FORTRAN 66 TO VS FORTRAN 77      
C   96-05-06  Y. ZHANG    REFINE THE CONTENTS OF PARAMETERS AND REMOVE
C                         SOME FTN STATEMENTS UNAVAILABLE.
C   98-07-29  VLCEK       COMPILE IN F90 (NO CODE CHANGES)
C                                                                       
C USAGE:    CALL SETPNQ                                                 
C   INPUT ARGUMENT LIST:  NONE                                          
C                                                                       
C   OUTPUT ARGUMENT LIST: NONE                                          
C                                                                       
C REMARKS: DATA IS PASSED IN COMMON; MOST VALUES SET IN PARAMETER       
C   STATEMENTS.  THIS SUBROUTINE HAS 34 STATEMENTS, USES 644 BYTES.     
C                                                                       
C ATTRIBUTES:                                                           
C   LANGUAGE: VS FORTRAN 90    CRAY FORTRAN                                         
C   MACHINE:  CRAY
C                                                                       
C$$$                                                                    

      IMPLICIT  INTEGER(G)

C     /G/ IS RESERVED FOR CONSTANTS NAMED IN A PARAMETER STATEMENT.   
C     THE COMPLETE LIST AND EXPLANATIONS OF PARAMETER NAMES CAN BE    
C     FOUND IN SUBROUTINE ACCUMU.                                     

C     ACTUAL NUMBER OF DESIRED PRESSURE LEVELS, THEIR PRESSURE       
C     VALUES AND Q VALUES ARE GIVEN IN THE PARAMETER STATEMENTS.     

C     GQ1 IS HEIGHT, GQ2 IS TEMPERATURE, GQ3 IS RELATIVE HUMIDITY.    
C     GQ4 IS U-COMPONENT OF WIND; V-COMPONENT IS ASSUMED TO BE GQ4+1. 
C     REMAINING GQ VALUES ARE RESERVED FOR FUTURE USE.                

      PARAMETER  (GNVAR=4, GNVARP=GNVAR+1, GNLEV=4)
      PARAMETER  (GQ1=7, GQ2=11, GQ3=52, GQ4=33, GQ5=34)
      PARAMETER  (GQ6=0, GQ7=0, GQ8=0, GQ9=0, GQ10=0)
      PARAMETER  (GP1=0, GP2=850, GP3=0, GP4=500, GP5=0, GP6=0)
      PARAMETER  (GP7=250, GP8=0, GP9=0, GP10=100, GP11=0, GP12=0)
      PARAMETER  (GP13=0, GP14=0, GP15=0)

      COMMON /LEVELS/ PLEV(GNLEV)  , IPL(GNLEV)    , QWANT(GNVARP)

      INTEGER    QWANT, PLEV
      DIMENSION  NP(15), NQ(10)

      DATA  NP /GP1, GP2, GP3, GP4, GP5,
     &          GP6, GP7, GP8, GP9, GP10,
     &          GP11, GP12, GP13, GP14, GP15/,
     &      NQ /GQ1, GQ2, GQ3, GQ4, GQ5,
     &          GQ6, GQ7, GQ8, GQ9, GQ10/

      N = 0
      DO 40 K=1,15
      IF(NP(K).EQ.0)  GO TO 30
      N = N + 1
      PLEV(N) = NP(K)
      IPL(N) = K
   30 CONTINUE
   40 CONTINUE

C     TAKE CARE OF Q VALUES HERE                                     

      DO 50 I=1,GNVARP
      QWANT(I) = NQ(I)
   50 CONTINUE

      RETURN
      END
