class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  def index
    if params[:tag]
      tags = Tag.where(name: params[:tag])
      @contacts = tags.map(&:contacts).flatten if tags.present? && tags.any?
    end
    @contacts = Contact.all if !@contacts.present? || @contacts.empty?
    @collection_size = @contacts.size
    @number_of_pages
    params[:pagination] = params[:pagination].nil? ? 10 : params[:pagination].to_i
    params[:page] = "1" if params[:page].nil?
    pages(@contacts, @collection_size, params[:pagination], params[:page])

  end

  def new
    @contact = Contact.new
    @contact.tags.build
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save!
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

    def pages(collection, collection_size, pagination_size, page)
      if collection_size >= 1
        @number_of_pages = collection_size / pagination_size
        modulo_page_nb_of_results = collection_size % pagination_size
        page = page.to_i
        if modulo_page_nb_of_results > 0
          @number_of_pages += 1
        end
        if modulo_page_nb_of_results > 0 && page == @number_of_pages
          @contacts = collection[
            ( collection_size - modulo_page_nb_of_results ),
            modulo_page_nb_of_results]
        else
          start = pagination_size * ( page - 1 )
          end_of = start + pagination_size
          @contacts = collection[start...end_of]
        end

      end
      params[:page] = page.to_s
    end

end
