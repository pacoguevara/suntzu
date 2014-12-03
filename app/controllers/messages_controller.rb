class MessagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = []
        Message.where(:user_id => current_user.id).order(created_at: :desc).to_a.each do |k,v|
          if k.nil? || k == 0
            count = "Sin Grupo"
          else
            count = UserMessage.where(:message_id => k).count
          end
          puts k.id
          puts k.message
          puts count
          hash = { "id" => k.id, "msg" => k.message, "count" => count}
          @messages.push hash
        end
        
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    id = params[:id]
    @message_info = []
    @users_msg = UserMessage.select("user_messages.*, users.name, users.first_name, users.last_name, users.cellphone")
    .where(:message_id => id).joins('INNER JOIN "users" ON "users"."id" = "user_messages"."user_id"')
    .to_a.each do |u|
      if !u.nil? || !u == 0
        if !u.message_sid.nil? || !u.message_sid == 0
          if !u.cellphone.nil? || !u.cellphone == 0
            if u.status != 'sent' || u.status != 'failed'
              status = Message.get_sms u.message_sid
              full_name = u.name + " " + u.first_name + " " + u.last_name
              UserMessage.update_status u.id, status
              if status == 'sent'
                hash = {"message_id" => u.id, "user_id" => u.user_id, "user_name" => full_name, "message_status" => 'Enviado'}
              else 
                hash = {"message_id" => u.id, "user_id" => u.user_id, "user_name" => full_name, "message_status" => 'Envío fallido'}
              end
            else
              if u.status == 'sent'
                hash = {"message_id" => u.id, "user_id" => u.user_id, "user_name" => full_name, "message_status" => 'Enviado'}
              else 
                hash = {"message_id" => u.id, "user_id" => u.user_id, "user_name" => full_name, "message_status" => 'Envío fallido'}
              end
            end
          else
            hash = {"message_id" => u.id, "user_id" => u.user_id, "user_name" => full_name, "message_status" => "Envío fallido"}
          end
        else
          puts "*********** NO TRAE NADA! *************"
          hash = {"message_id" => u.id, "user_id" => u.user_id, "user_name" => full_name, "message_status" => "Envío fallido"}
        end
        @message_info.push hash
      else
        puts ">>>>>>>>>>>>>>>>>>>>>>>>   <<<<<<<<<<<<<<<<<<<<"
      end 
    end
  end

  # GET /messages/new
  def new
    @users = User.all.limit(User.per_page).offset(0).order(:created_at)
    @users_t = User.all
    @message = Message.new
    @militants = User.all
    @canedit = false
    @municipalities = Municipality.all
    @subenlace = User.where(:role => 'subenlace')
    @enlace = User.where(:role => 'enlace')
    @coordinador = User.where(:role => 'coordinador')
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