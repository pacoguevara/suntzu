class UserMailer < ActionMailer::Base
  default from: "fguevara@tegik.com"

  def download_polling(file)
  	attachments['lista_nominal.xls'] = file.string
    
    #mail(to: 'pacoguevaraa@gmail.com', subject: 'Descarga de lista nominal')
    mail(to: 'heladosnuevoleon@gmail.com', cc: 'dederico@gmail.com', subject: 'Descarga de lista nominal')
  end
end
