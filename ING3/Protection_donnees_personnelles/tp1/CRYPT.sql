
CREATE OR REPLACE FUNCTION pading (p_text  IN VARCHAR2) 
RETURN VARCHAR2
IS
    l_units  NUMBER;
    res VARCHAR2(1000);
  BEGIN
    res := p_text;
    IF LENGTH(p_text) MOD 8 > 0 THEN
      l_units := TRUNC(LENGTH(p_text)/8) + 1;
      res := RPAD(p_text, l_units * 8, '-');
    END IF;
    RETURN res;
  END;
/

select pading('test') from dual;

CREATE OR REPLACE FUNCTION encrypt (text  IN VARCHAR2, key IN VARCHAR2) 
RETURN VARCHAR2
IS
    pad VARCHAR2(1000);
    res VARCHAR2(1000);
  BEGIN
  ???? := pading(????);
  ???? := DBMS_OBFUSCATION_TOOLKIT.desencrypt(
          input => UTL_RAW.cast_to_raw(????), 
          key  => UTL_RAW.cast_to_raw(????) );
  RETURN ????;
  END;
/

select encrypt('test', '12345678') from dual;

CREATE OR REPLACE FUNCTION decrypt (text  IN VARCHAR2, key IN VARCHAR2) 
RETURN VARCHAR2
IS
  dec VARCHAR2(1000);
  res VARCHAR2(1000);
BEGIN
  ???? := UTL_RAW.CAST_TO_VARCHAR2(
          DBMS_OBFUSCATION_TOOLKIT.desdecrypt(
           input => ?????,
           key   => UTL_RAW.cast_to_raw(????) ) );
  ???? := RTrim(????, '-');
  RETURN res;
END;
/

select decrypt('2FD0D87C2F466C21', '12345678') from dual;
