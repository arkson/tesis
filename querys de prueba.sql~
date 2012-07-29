 delete from alquileres; delete from lines_items; delete from carts;update ejemplares set estatus_ejemplar = 'Disponible'; 


[CONSTRAINT símbolo] FOREIGN KEY [id] (nombre_índice, ...)
    REFERENCES nombre_de_tabla (nombre_índice, ...)
    [ON DELETE {RESTRICT | CASCADE | SET NULL | NO ACTION}]
    [ON UPDATE {RESTRICT | CASCADE | SET NULL | NO ACTION}]



ALTER TABLE ejemplares
ADD CONSTRAINT ejemplares_fk_libro FOREIGN KEY(libro_id) REFERENCES libros (id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT ejemplares_fk_libreria FOREIGN KEY(libreria_id) REFERENCES librerias (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE lines_items
ADD CONSTRAINT lines_items_fk_ejemplar FOREIGN KEY(ejemplar_id) REFERENCES ejemplares (id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT lines_items_fk_cart FOREIGN KEY(cart_id) REFERENCES carts (id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT lines_items_fk_alquiler FOREIGN KEY(alquiler_id) REFERENCES alquileres (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE carts
ADD CONSTRAINT carts_fk_usuario FOREIGN KEY(usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE devoluciones
ADD CONSTRAINT dev_fk_alquiler FOREIGN KEY(alquiler_id) REFERENCES alquileres (id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT dev_fk_line_item FOREIGN KEY(line_item_id) REFERENCES lines_items (id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE alquileres
ADD CONSTRAINT alquileres_fk_conf FOREIGN KEY (configuracion_id) REFERENCES configuraciones (id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE libros
ADD CONSTRAINT libros_fk_editorial FOREIGN KEY(editorial_id) REFERENCES editoriales (id) 
ON DELETE SET NULL
ON UPDATE CASCADE,
ADD CONSTRAINT dev_fk_dependencia FOREIGN KEY(dependencia_id) REFERENCES dependencias (id) 
ON DELETE  SET NULL 
ON UPDATE CASCADE;


ALTER TABLE libros
ADD CONSTRAINT libros_fk_areas FOREIGN KEY(area_conocimiento_id) REFERENCES areas_conocimientos (id) 
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE usuarios
ADD CONSTRAINT usuarios_fk_dependencias FOREIGN KEY (dependencia_id) REFERENCES dependencias (id)
ON DELETE SET NULL 
ON UPDATE CASCADE;







