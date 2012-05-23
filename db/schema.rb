# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120509205456) do

  create_table "alquileres", :force => true do |t|
    t.integer  "line_item_id"
    t.integer  "usuario_id"
    t.date     "fecha_fin"
    t.string   "estatus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alquileres", ["line_item_id"], :name => "index_alquileres_on_line_item_id"
  add_index "alquileres", ["usuario_id"], :name => "index_alquileres_on_usuario_id"

  create_table "areas_conocimientos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuraciones", :force => true do |t|
    t.integer  "periodo"
    t.integer  "ano"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.integer  "max_num_libro"
    t.boolean  "libro_repetido"
    t.integer  "tiempo_prealquiler"
    t.string   "tipo_periodo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activo"
  end

  create_table "dependencias", :force => true do |t|
    t.string   "nombre"
    t.string   "tipo_dependencia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editoriales", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ejemplares", :force => true do |t|
    t.string   "numero_ejemplar"
    t.decimal  "costo_alquiler",   :precision => 10, :scale => 0
    t.string   "tipo_adquisicion"
    t.date     "fecha_ingreso"
    t.text     "observacion"
    t.string   "nro_factura"
    t.string   "en_uso"
    t.boolean  "activo"
    t.string   "estatus_ejemplar"
    t.integer  "libro_id"
    t.integer  "libreria_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ejemplares", ["libreria_id"], :name => "index_ejemplares_on_libreria_id"
  add_index "ejemplares", ["libro_id"], :name => "index_ejemplares_on_libro_id"

  create_table "librerias", :force => true do |t|
    t.string   "nombre"
    t.string   "telefono"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libros", :force => true do |t|
    t.string   "cota"
    t.string   "titulo"
    t.string   "autor"
    t.string   "imagen_content_type"
    t.string   "imagen_file_name"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.integer  "edicion"
    t.string   "lugar_impresion"
    t.integer  "ano"
    t.string   "isbn"
    t.integer  "editorial_id"
    t.integer  "area_conocimiento_id"
    t.integer  "dependencia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "libros", ["area_conocimiento_id"], :name => "index_libros_on_area_conocimiento_id"
  add_index "libros", ["dependencia_id"], :name => "index_libros_on_dependencia_id"
  add_index "libros", ["editorial_id"], :name => "index_libros_on_editorial_id"

  create_table "lines_items", :force => true do |t|
    t.integer  "ejemplar_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",    :default => 1
    t.integer  "alquiler_id"
  end

  add_index "lines_items", ["cart_id"], :name => "index_lines_items_on_cart_id"
  add_index "lines_items", ["ejemplar_id"], :name => "index_lines_items_on_ejemplar_id"

  create_table "noticias", :force => true do |t|
    t.string   "titulo"
    t.string   "imagen_content_type"
    t.string   "imagen_file_name"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.text     "contenido"
    t.string   "tipo_contenido"
    t.date     "fecha"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "cedula"
    t.string   "password_digest"
    t.string   "correo"
    t.integer  "unid_creditos"
    t.integer  "dependencia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rol"
  end

  add_index "usuarios", ["dependencia_id"], :name => "index_usuarios_on_dependencia_id"

end