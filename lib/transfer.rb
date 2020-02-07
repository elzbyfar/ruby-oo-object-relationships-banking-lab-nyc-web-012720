class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  @@all = []
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
    @@all << self
  end 

  def self.all
    @@all
  end 

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
  	if self.valid?
      if @sender.balance > amount && @status == 'pending'
        @sender.deposit(-@amount)
        @receiver.deposit(@amount)
        @status = 'complete'
      else
        @status = 'rejected'
        return 'Transaction rejected. Please check your account balance.'
      end
  	else 
  		@status = 'rejected'
      return 'Transaction rejected. Please check your account balance.'
  	end
  end

  def reverse_transfer
  	if self.valid?
      if @sender.balance > amount && @status == 'complete'
        @sender.deposit(@amount)
        @receiver.deposit(-@amount)
        @status = 'reversed'
      else
        @status = 'rejected'
        return 'Transaction rejected. Please check your account balance.'
      end
  	else 
  		@status = 'rejected'
      return 'Transaction rejected. Please check your account balance.'
  	end
  end 

end
