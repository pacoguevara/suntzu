class UserMailer < ActionMailer::Base
  default from: ""

  def download_polling(file)
  	attachments['lista_nominal.xls'] = file.string

    #mail(to: 'pacoguevaraa@gmail.com', subject: 'Descarga de lista nominal')
    mail(to: 'heladosnuevoleon@gmail.com', cc: 'dederico@gmail.com', subject: 'Descarga de lista nominal')
  end

  def download_subordinados(file, filename)
  	attachments[filename] = file
  	#mail(to: 'pacoguevaraa@gmail.com', subject: 'Descarga de subordinados')
    mail(to: 'heladosnuevoleon@gmail.com', cc: 'dederico@gmail.com', subject: 'Descarga de subordinados')
  end
end
