class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy code ]
  helper_method :color_helper, :string_color_helper

  # GET /groups or /groups.json
  def index
    @groups = Group.all.includes(:attempts)
  end

  # GET /groups/1 or /groups/1.json
  def show
    respond_to do |format|
      format.html do
      end
      format.pdf do
        html = render_to_string(layout: false, action: 'show.html.erb')

        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/app/javascript/stylesheets/pdf.css"
        send_data(kit.to_pdf, filename: 'report.pdf', type: 'application/pdf', disposition: 'inline')
      end
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url, notice: "Группа успешно создана"  }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_url, notice: "Группа успешно изменена"  }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Группа успешно удалена" }
      format.json { head :no_content }
    end
  end

  def code
    @svg = RQRCode::QRCode.new(welcome_code_url(@group)).as_svg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.includes(:attempts).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.fetch(:group, {}).permit(:custom_name)
    end

  def color_helper(val, max_val)
    if val.to_f / max_val < 0.5
      'text-danger'
    elsif val.to_f / max_val < 0.88
      'text-warning'
    else
      'text-success'
    end
  end

  def string_color_helper(val, arr)
    if arr.include?(val)
      'text-success'
    else
      'text-danger'
    end
  end
end
