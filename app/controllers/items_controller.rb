class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @date = DateTime.now.strftime("%Y/%m/%d")
    @all_items = Item.all
    @todo_items = []
    @done_items = []

    @all_items.each do |item|
      item_date = item.associated_date
      next if item_date == nil
      next if item_date.strftime("%d/%m/%Y") != @date
      if item.done
        @done_items.push item
      else
        @todo_items.push item
      end
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @date = DateTime.now
    @item = Item.new(item_params.to_h.update({:associated_date => @date}))

    respond_to do |format|
      if @item.save
        format.html { redirect_to '/', notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggleStatus
    @item = Item.find(params[:item_id])
    toggled_item = {:done => !@item.done,
                    :associated_date => @item.associated_date, 
                    :summary => @item.summary,
                    :description => @item.description}
    @item.update(toggled_item)
    redirect_to '/'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:done, :associated_date, :summary, :description)
    end
end
