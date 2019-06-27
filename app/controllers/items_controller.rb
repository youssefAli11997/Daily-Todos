class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index]

  # GET /items
  # GET /items.json
  def index  
    session[:mainReturn] = '/'
    @all_items = Item.all
    @todo_items = []
    @done_items = []

    @all_items.each do |item|
      item_date = item.associated_date
      next if item_date == nil
      next if item_date.strftime("%Y/%m/%d") != $date.strftime("%Y/%m/%d")
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
    @item = Item.new(item_params.to_h.update({:associated_date => $date}))

    respond_to do |format|
      if @item.save
        format.html { redirect_to '/', notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: '/' }
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
        format.html { redirect_to session[:mainReturn], notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: '/' }
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
      format.html { redirect_to session[:mainReturn], notice: 'Item was successfully destroyed.' }
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
    redirect_to session[:mainReturn]
  end

  def setPrevDay
    $date = $date.prev_day
    redirect_to '/'
  end

  def setNextDay
    $date = $date.next_day
    redirect_to '/'
  end

  def setToday
    $date = DateTime.now
    redirect_to '/'
  end

  def goto
    old_date = $date
    begin
      $date = DateTime.parse("#{params['selected_date(1i)']}/" + 
        "#{params['selected_date(2i)']}/#{params['selected_date(3i)']}")
    rescue
      $date = old_date
    end

    redirect_to session[:mainReturn]
  end

  def todoToday
    @item = Item.find(params[:item_id])
    toggled_item = {:done => @item.done,
                    :associated_date => DateTime.now.strftime("%Y/%m/%d"), 
                    :summary => @item.summary,
                    :description => @item.description}
    @item.update(toggled_item)
    redirect_to session[:mainReturn]
  end

  def showAllTodo
    session[:mainReturn] = '/show_all_todo'
    @items = Item.all
  end

  def showAllDone
    session[:mainReturn] = '/show_all_done'
    @items = Item.all
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

    def set_date
      unless $date
        $date = DateTime.now
      end
    end
end
