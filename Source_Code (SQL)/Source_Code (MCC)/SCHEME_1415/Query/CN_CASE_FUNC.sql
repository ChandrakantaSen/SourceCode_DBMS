function CF_1Formula return Number is
begin
	  :TGT := 100;
	  :PER_KG = TRUNC((:TY_VOL - 1000)/100);
	  IF :TY_VOL_27 >= :TGT THEN
		 :CN1 := 400;
	  ELSE
		 :CN1 := 0;
	  END IF;

	  CASE 
		--	  WHEN :TY_VOL > 1000 THEN :CN2 := TRUNC((:TY_VOL - 1000)/100)*350;
			  WHEN :TY_VOL > 1000 THEN :CN2 := :PER_KG * 350;
			  WHEN :TY_VOL = 1000 THEN :CN2 := 3500;
			  WHEN :TY_VOL >= 750 THEN :CN2 := 2250;
			  WHEN :TY_VOL >= 500 THEN :CN2 := 1250;
			  WHEN :TY_VOL >= 250 THEN :CN2 := 500;
			  ELSE :CN2 := 0;
	  END CASE;
RETURN 0;
end;