Rails.application.routes.draw do
  get "/", to: "application#welcome"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"
  delete "/shelters/:id", to: "shelters#destroy"

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/veterinary_offices", to: "veterinary_offices#index"
  get "/veterinary_offices/new", to: "veterinary_offices#new"
  get "/veterinary_offices/:id", to: "veterinary_offices#show"
  post "/veterinary_offices", to: "veterinary_offices#create"
  get "/veterinary_offices/:id/edit", to: "veterinary_offices#edit"
  patch "/veterinary_offices/:id", to: "veterinary_offices#update"
  delete "/veterinary_offices/:id", to: "veterinary_offices#destroy"

  get "/veterinarians", to: "veterinarians#index"
  get "/veterinarians/:id", to: "veterinarians#show"
  get "/veterinarians/:id/edit", to: "veterinarians#edit"
  patch "/veterinarians/:id", to: "veterinarians#update"
  delete "/veterinarians/:id", to: "veterinarians#destroy"

  get "/shelters/:shelter_id/pets", to: "shelters#pets"
  get "/shelters/:shelter_id/pets/new", to: "pets#new"
  post "/shelters/:shelter_id/pets", to: "pets#create"

  get "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinary_offices#veterinarians"
  get "/veterinary_offices/:veterinary_office_id/veterinarians/new", to: "veterinarians#new"
  post "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinarians#create"

  get "/pets_applications/new", to: "pets_applications#new"
  post "/pets_applications", to: "pets_applications#create"
  get "/pets_applications/:id", to: "pets_applications#show"
  patch "/pets_applications/:id", to: "pets_applications#update"

  get "/admin/shelters", to: "admin#shelters_index"
  get "/admin/pets_applications/:id", to: "admin#show"
  patch "/admin/pets_applications/:id", to: "admin#approve_reject"
  get "/admin/pets_applications/", to: "admin#index"

end