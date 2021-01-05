class Api::V1::EmployeesController < ApiController
    before_action :set_employee, only: [:show, :update, :destroy]

    # 拾えなかったExceptionが発生したら500 Internal server errorを応答する
    rescue_from Exception, with: :render_status_500

    # ActiveRecordのレコードが見つからなければ404 not foundを応答する
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: { error: '404 not found' }, status: 404
    end
  
    def index
      # selectメソッドとは、取得したい列を指定することが出来るメソッドのこと
      employees = Employee.select(:id, :name, :department, :gender)
      render json: employees
    end
  
    def show
      render json: @employee
    end

    def create
        employee = Employee.new(employee_params)
        if employee.save
          render json: employee, status: :created
        else
          render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
      # モデルオブジェクト.update_attributes(キー: 値, キー: 値 … )
      # Hashを引数に渡してデータベースのレコードを複数同時に更新
        if @employee.update(employee_params)
            # Status Code:200 OKを返す
            head :no_content            
        else
            render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        ## 削除に失敗した場合に Exception を発生させて、rescue_from Exception で拾う
        @employee.destroy!
        head :no_content
    end
  
    private
  
      def set_employee
        @employee = Employee.find(params[:id])
      end
  
      def employee_params
        params.fetch(:employee, {}).permit(:id, :name, :department, :gender, :birth, :joined_date, :payment, :note)
      end
  
      def render_status_404(exception)
        render json: { errors: [exception] }, status: 404
      end
  
      def render_status_500(exception)
        render json: { errors: [exception] }, status: 500
      end
  end