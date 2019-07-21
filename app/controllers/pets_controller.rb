class PetsController < ApplicationController

  # display a list of all pets
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  # return an HTML form for creating a new pet
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  # create a new pet
  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find_by(id: params["pet"]["owner_id"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  # return an HTML form for editing a pet for an owner
  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  #	display a specific pet
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # update a specific pet + owners
  patch '/pets/:id' do
    ####### bug fix
    # if !params[:pet].keys.include?("owner_ids")
    # params[:pet]["owner_ids"] = []
    # end
    #######

    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find_by(id: params["pet"]["owner_id"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
