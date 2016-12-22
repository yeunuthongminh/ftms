class ExportFile::PdfsController < ApplicationController

  def show
    @user = User.find_by id: params[:user_id]
    @supports = Supports::UserSupport.new @user
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@user.name}_#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}",
          template: "export_file/pdfs/show.html.erb",
          disposition: "attachment",
          layout: "pdf",
          orientation: "Landscape",
          viewport_size: "1280x1024",
          encoding: "UTF-8"
      end
    end
  end
end
