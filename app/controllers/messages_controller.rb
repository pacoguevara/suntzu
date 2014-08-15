class MessagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    @militants = Militant.all
    @canedit = false
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    twilio_sid = "ACed7a7ef98a126abc33ff867370d890c9"
    twilio_token = "6e26775044f3087e7d9f44f003db29ae"
    twilio_phone_number = "+18027339326"
    #number_to_send_to = "+528341444418"
    number_to_send_to = "+528180291458"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => message_params[:message]
    )
    redirect_to :back
    #respond_to do |format|
      #if @message.save
        # format.html { redirect_to @message, notice: 'Message was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @message }
      # else
      #   format.html { render action: 'new' }
      #   format.json { render json: @message.errors, status: :unprocessable_entity }
      # end
    #end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :message, :deep)
    end
end
