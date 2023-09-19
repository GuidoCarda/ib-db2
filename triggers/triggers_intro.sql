CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name FOR EACH ROW
trigger_body;


CREATE TRIGGER productos_ai AFTER INSERT ON PRODUCTOS FOR EACH ROW
INSERT INTO reg_productos(codigoarticulo, nombrearticulo, precio, insertado) 
VALUES (new.codigoarticulo, new.nombrearticulo, new.precio);

CREATE TRIGGER control_productos AFTER INSERT ON productos FOR EACH ROW
INSERT INTO reg_productos (codigo, momento) VALUES (new.codigo, now());