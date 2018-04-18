class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  def index
    if params[:tag]
      tags = Tag.where(name: params[:tag])
      @contacts = tags.map(&:contacts).flatten if tags.present? && tags.any?
    end
    params[:pagination] = params[:pagination].nil? ? 10 : params[:pagination].to_i
    params[:page] = "1" if params[:page].nil?
    @collection_size = !@contacts.nil? ? @contacts.count : Contact.count
    @number_of_pages = @collection_size.fdiv(params[:pagination]).ceil
    @contacts = Contact.limit(params[:pagination])
    .offset((params[:page].to_i - 1) * params[:pagination])

  end

  def new
    @contact = Contact.new
    @contact.tags.build
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to contact_path(@contact),
        notice: 'Contact was successfully created.'
    else

      render :new
    end

  end

  def edit
    @contact.tags.build if @contact.tags.empty?
  end

  def update
    if @contact.update(contact_params)
      redirect_to contact_path(@contact),
        notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path,
      notice: 'Contact was successfully destroyed.'
  end

  private

    def contact_params
      params.require(:contact).permit(
        :id, :firstname, :lastname, :email, :tel, :address, :tag_list,
        tags_attributes: [:id, :name, :_destroy]
        )
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

end
