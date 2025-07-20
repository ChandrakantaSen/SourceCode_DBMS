function CF_1Formula return Number is
begin
  :TGT := 100;
  IF :TY_VOL_27 >= :TGT THEN
  	:CN1 := 400;
  ELSE
  	:CN1 := 0;
  END IF;
  
IF :TY_VOL > 1000 THEN
     :CN2 := TRUNC((:TY_VOL - 1000)/100)*350;
ELSE 
     IF :TY_VOL = 1000 THEN
          :CN2 := 3500;
     ELSE 
          IF :TY_VOL >= 750 THEN
               :CN2 := 2250;
	ELSE 
	    IF :TY_VOL >= 500 THEN
                   :CN2 := 1250;	
	    ELSE 
	        IF :TY_VOL >= 250 THEN
		   :CN2 := 500;
	        ELSE
		   :CN2 := 0;
	        END IF;
	    END IF;	
	END IF;
     END IF;  	
END IF;
	RETURN 0;
end;
