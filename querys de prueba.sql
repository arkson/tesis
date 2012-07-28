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
ADD CONSTRAINT devoluciones_fk_alquiler FOREIGN KEY(alquiler_id) REFERENCES alquileres (id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT devoluciones_fk_line_item FOREIGN KEY(line_item_id) REFERENCES lines_items (id) ON DELETE CASCADE ON UPDATE CASCADE;

