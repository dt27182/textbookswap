Textbookswap::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  #homepage
  match '/' => 'index#index', :as => :index
  #page to input courses into db
  get '/admin/courses/input/:term/:year' => 'courses#input', :as => :course_input
  #page to select a course
  get '/:transaction_type/course/show' => 'courses#show', :as => :show_courses
  #page to find the course id from a long department name and number
  post '/:transaction_type/course/find' => 'courses#find', :as => :find_course
  #page to show the books that belong to a course
  get '/:transaction_type/courses/:id/book/show' => 'courses#show_books', :as => :show_books
  #page to input details for a unlisted book
  get '/courses/:id/book/new' => 'books#display_new', :as => :display_new_book
  #page to insert unlisted book into db
  put '/courses/:id/book/new' => 'books#create_new', :as => :create_new_book
  #page to show all the postings for a book
  get '/books/:id/posting/show' => 'books#show_postings', :as => :show_postings
  #page to input details of a new posting
  get '/books/:book_id/posting/new' => 'postings#display_new', :as => :display_new_posting
  #page to submit a new posting
  post '/books/:book_id/posting/new' => 'postings#create_new', :as => :create_new_posting
  #page to let the buyer enter a msg and contact info
  get '/books/:book_id/postings/:posting_id' => 'posting#show', :as => :show_posting
  #page finalize a buy
  post '/books/:book_id/postings/:posting_id' => 'posting#commit_buy', :as => :commit_buy_posting
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
