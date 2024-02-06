module master(
  inout reg sda,
  output reg scl,
  inout reg [7:0]add , data,
  input load_1, load_2
);

reg [7:0]add_reg , data_reg;


//address load
always @ (posedge scl)
begin
  if(load_1)
    add_reg <= add;
  else
    add_reg <= add_reg;
	
end

//data load
always @ (posedge scl)
begin
  if(load_2)
    data_reg <= data;
  else
    data_reg <= data_reg;	
end


//counter
always @(posedge scl)
begin 



//i2c communication

  if(load_3 != 0)begin
    counter <= 0;
  end
  else(load_3 == 0)begin
    counter = counter +1;
  end
end
  

always @(posedge scl)
begin
  if(load_3 == 0)begin
    if(counter <= 7)begin
      sda<=add_reg[7];
      add_reg<={add_reg[6:0],1’b0};
    end
	 
	 
	 
    if(counter == 8)begin
      if(sda=1)
        ack=sda;
		else
        ack=0;		
    end
	 else
	   ack=0;
		
		
		
	 if(ack==1)begin
	   if(counter <= 16)begin
		  sda<=data_reg[7];
        data_reg<={data_reg[6:0],1’b0};
	   end
		if(counter == 17)begin
        if(sda=1)
          ack2=sda;
		  else
          ack2=0;		
        end
	   else
	     ack2=0;
		if(ack2==1)begin
	     if(counter <= 25)begin
		    sda<=data_reg[7];
          data_reg<={data_reg[6:0],1’b0};
	     end
	  end
  
  
  end
  else begin
    sda <= 1
  end 
    
end



endmodule
