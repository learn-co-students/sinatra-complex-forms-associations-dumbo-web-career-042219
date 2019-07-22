class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end
  #Create
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet_name])
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
    else
      @pet.owner = Owner.find(params[:owner_id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
  #Read
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  #Update
  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if params[:owner_name].empty?
      @pet.owner.update(name: params[:owner][:name])
    else
      @pet.owner.update(name: params[:owner_name])
    end
    redirect to "pets/#{@pet.id}"
  end
end
