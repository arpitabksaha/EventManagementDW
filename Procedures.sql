create or replace PROCEDURE VENUEORGANISER (  
ORGANISER_ID TABLEORGANISER.ORGANISER_ID%TYPE,  
ORGANISER_NAME TABLEORGANISER.ORGANISER_NAME%TYPE,  
ORGANISER_CONTACT TABLEORGANISER.ORGANISER_CONTACT%TYPE,
ORGANISER_ADDRESS TABLEORGANISER.ORGANISER_ADDRESS%TYPE)    
AS  
BEGIN  
INSERT INTO TABLEORGANISER(ORGANISER_ID, ORGANISER_NAME, ORGANISER_CONTACT, ORGANISER_ADDRESS)  
VALUES (ORGANISER_ID, ORGANISER_NAME, ORGANISER_CONTACT, ORGANISER_ADDRESS);  
COMMIT;  
END VENUEORGANISER;

-----------------------------------------------------------------------------------


create or replace PROCEDURE EVENT(  
EVENT_ID TABLEEVENT.EVENT_ID%TYPE,  
EVENT_TYPE TABLEEVENT.EVENT_TYPE%TYPE,  
EVENT_STARTDATE TABLEEVENT.EVENT_STARTDATE%TYPE,
TICKET_COUNT TABLEEVENT.TICKET_COUNT%TYPE,
EVENT_VENUE TABLEEVENT.EVENT_VENUE%TYPE,
EVENT_COUNT TABLEEVENT.EVENT_COUNT%TYPE
)    
AS  
BEGIN  
INSERT INTO TABLEEVENT(EVENT_ID, EVENT_TYPE, EVENT_STARTDATE, TICKET_COUNT, EVENT_VENUE, EVENT_COUNT)  
VALUES (EVENT_ID, EVENT_TYPE, EVENT_STARTDATE, TICKET_COUNT, EVENT_VENUE, EVENT_COUNT);  
COMMIT;  
END EVENT;


---------------------------------------------------------------------------------

create or replace PROCEDURE PURCHASETRANSACTION(  
CUSTOMER_ID TABLECUSTOMER.CUSTOMER_ID%TYPE,  
CUSTOMER_NAME TABLECUSTOMER.CUSTOMER_NAME%TYPE,  
CUSTOMER_CONTACT TABLECUSTOMER.CUSTOMER_CONTACT%TYPE,
CUSTOMER_EMAIL TABLECUSTOMER.CUSTOMER_EMAIL%TYPE,
TICKET_ID TABLECUSTOMER.TICKET_ID%TYPE,
TICKET_CATEGORY TABLETICKETS.TICKET_CATEGORY%TYPE,
PURCHASE_DATE TABLETICKETS.PURCHASE_DATE%TYPE,
TICKET_PRICE TABLETICKETS.TICKET_PRICE%TYPE
)    
AS  
BEGIN  
INSERT INTO TABLETICKETS(TICKET_ID, TICKET_CATEGORY, PURCHASE_DATE, TICKET_PRICE)  
VALUES (TICKET_ID, TICKET_CATEGORY, PURCHASE_DATE, TICKET_PRICE) ;  

INSERT INTO TABLECUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_CONTACT, CUSTOMER_EMAIL, TICKET_ID)  
VALUES (CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_CONTACT, CUSTOMER_EMAIL, TICKET_ID) ;  
COMMIT;  
END PURCHASETRANSACTION;

--------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE ASSIGNTICKETS AS 
BEGIN
  Update TABLETICKETS
  SET organiserreseller_id = 
  (
  select a.organiserreseller_id from TORGANISERRESELLER a 
  left outer join TABLETICKETS b 
  on a.organiserreseller_id = b.organiserreseller_id
  where b.organiserreseller_id is null
  and rownum <=1
  )
  WHERE ORGANISERRESELLER_ID IS NULL
  AND ROWNUM <= 100;
END ASSIGNTICKETS;

-------------------------------------------------------------------------------


/*implementation*/
BEGIN
   VENUEORGANISER('999','ARPITA',9999999999,'ABCDEFGHIJKLMONP');
   EVENT('YZYZ', 'SINGLE', SYSDATE , 2, 'ASDFHJ',1);
   PURCHASETRANSACTION('aaaaaazzz','arnold',5676787890,'abc@def.com','ZZZZZ','VIP', SYSDATE ,100);
   ASSIGNTICKETS; 
END;

--------------------------------------------------------------------------------