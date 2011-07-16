class UploadsController < ApplicationController

 def index
    @uploads = Upload.all    
  end

  def show
    @upload = Upload.find(params[:id])
   
  end

  def new
    @upload = Upload.new 
  end

  def edit
    @upload = Upload.find(params[:id])
  end

  def create
   # @upload = Upload.new (params[:upload])
   @upload = Upload.create( params[:upload] )


      if @upload.save
       redirect_to(@upload, :notice => 'document was successfully created.')
      else
    render :action => "new"    
      end
 
  end

  def update
    @upload = Upload.find(params[:id])
      if @upload.update_attributes(params[:upload])
        redirect_to(@upload, :notice => 'upload was successfully updated.')   
      else
        render :action => "edit" 
      
      
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    redirect_to(uploads_url) 
 
    end

def verify
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if(((Time.now.utc-@upload.created_at)/86400).to_i<@upload.folder_days)
	format.html
      else
	render :text => "Sorry Link expried."
      end
    end
  end

  def download
    @upload = Upload.find(params[:id])

      if(@upload.folder_password == params[:password])
        send_file(@upload.folder.path, :type => @upload.folder_content_type, :disposition => 'inline')
      else
	render :text => "Incorrect password"
      end
  end
end
