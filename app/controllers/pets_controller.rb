class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    unless params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name]) 
    else
      owner = Owner.find(params[:owner_id])
    end
    @pet = Pet.create(name: params[:pet_name], owner_id: owner.id)
    # binding.pry
    owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    @owners = Owner.all
    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    # binding.pry
    pet = Pet.find(params[:id])
    pet.update(name: params[:pet_name])
    if params[:owner_name].empty?
      pet.owner.update(name: params[:owner][:name])
    else
      pet.owner.update(name: params[:owner_name])
    end
    redirect to "pets/#{@pet.id}"
  end
end