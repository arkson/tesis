Tesis::Application.routes.draw do
  
  resources :devoluciones

  resources :alquileres

  resources :configuraciones

  resources :noticias

  controller :sesiones do

	get 'login' => :nuevo
	post 'login' => :crear
	delete 'logout' => :eliminar

  end


  #get "sesiones/nuevo"

  #get "sesiones/crear"

  #get "sesiones/eliminar"

  resources :usuarios  

  resources :lines_items

  resources :carts

  get "ppal_admin/index"

  get "informacion/historia"

  get "informacion/servicios"

  get "informacion/normativas"

  get "informacion/horarios"

  get "inicio/index"

  get "inicio/catalogo"
  
  get "inicio/olvido_clave"
  
  post "inicio/olvido_clave"
  
  get "ppal_estudiante/index"

  get "ppal_estudiante/ver_alquiler"
  
  get "ppal_estudiante/ver_datos"
  
  get "ejemplares/index"

  get "libros/index"

  get "editoriales/index"

  get "areas_conocimientos/index"

  get "dependencias/index"

  get "librerias/index"

  resources :ejemplares

  resources :libros

  resources :editoriales

  resources :areas_conocimientos

  resources :dependencias

  resources :librerias

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'inicio#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
