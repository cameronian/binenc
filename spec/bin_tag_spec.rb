

RSpec.describe "BinTag helper" do

  it 'allows creation of constant and later retrieve through API' do
   
    bt = Binenc::BinTag.instance
    bt.define_constant(:name, 0x01023)

    expect(bt.constant_value(:name) == 0x01023).to be true

  end

  it 'handle duplication of keys based on user configurable flag' do
    
    bt = Binenc::BinTag.instance
    expect(bt.is_raise_on_constant_key_duplicate?).to be false

    bt.define_constant(:second, "testing")

    bt.raise_on_constant_key_duplicate = true
    expect(bt.is_raise_on_constant_key_duplicate?).to be true

    expect {
      bt.define_constant(:second, "testing")
    }.to raise_exception(Binenc::BinTagConstantKeyAlreadyExist)

  end

  it 'uses as DSL' do
    bt = Binenc::BinTag.instance
    bt.load do
      define_constant :london, "bridge"
    end

    expect(bt.constant_value(:london) == "bridge").to be true

  end

  it 'create the hirerchy tree of OID' do
    
    bt = Binenc::BinTag.instance
    bt.define_constant(:root, "2.8.3")

    bt.define_constant(:jan, ".12.11", :root)

    expect(bt.constant_value(:root) == "2.8.3").to be true
    expect(bt.constant_value(:jan) == "2.8.3.12.11").to be true

    bt.raise_on_constant_key_duplicate = true
    expect{
      bt.define_constant(:jan, ".34", :root)
    }.to raise_exception(Binenc::BinTagConstantKeyAlreadyExist)

    expect{
      bt.define_constant(:feb, ".34", :haha)
    }.to raise_exception(Binenc::BinTagConstantKeyNotFound)
  end

end
