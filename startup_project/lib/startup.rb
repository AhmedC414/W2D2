require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
        # hash.each do |title, salary|
        #     @salaries[title] = Employee.new(name, title).pay(salary)
        # end
    end

    def valid_title?(str)
        if @salaries.has_key?(str)
            return true
        else
            return false
        end
    end

    def >(start_up)
        if self.funding > start_up.funding
            return true
        else
            return false
        end
    end

    def hire(name, title)
        if self.valid_title?(title)
            @employees << Employee.new(name, title)
        else
            raise "something went wrong"
        end
    end

    def size
        @employees.length
    end
    
    def pay_employee(employee)
        owed = @salaries[employee.title]
        if @funding >= owed
            employee.pay(owed)
            @funding -= owed
        else
            raise "not enough funds"
        end
    end

    def payday
        employees.each { |employee| pay_employee(employee)}
    end

    def average_salary
        sum = @employees.map { |employee| @salaries[employee.title] }.sum
        sum / self.size.to_f
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(start_up)
        @funding += start_up.funding
        start_up.salaries.each do |k, v|
            if !@salaries.has_key?(k)
                @salaries[k] = v
            end
        end
        @employees = @employees + start_up.employees
        start_up.close
     end

    
end
