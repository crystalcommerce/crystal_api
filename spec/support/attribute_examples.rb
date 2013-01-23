shared_examples_for "money attribute" do
  context "string argument" do
    subject { CrystalApi::Variant.new("#{attribute}" => "5.0")}

    it "parses as money" do
      subject.send(attribute).should == Money.new(500)
    end
  end

  context "integer argument" do
    subject { CrystalApi::Variant.new("#{attribute}" => 5) }

    it "parses as money" do
      subject.send(attribute).should == Money.new(500)
    end
  end

  context "float argument" do
    subject { CrystalApi::Variant.new("#{attribute}" => 5.0) }

    it "parses as money" do
      subject.send(attribute).should == Money.new(500)
    end
  end

  context "money argument" do
    subject { CrystalApi::Variant.new("#{attribute}" => Money.new(500)) }

    it "parses as money" do
      subject.send(attribute).should == Money.new(500)
    end
  end
end

shared_examples_for "integer attribute" do
  context "string argument" do
    subject { CrystalApi::Variant.new("#{attribute}" => "5") }

    it "parses as integer" do
      subject.send(attribute).should == 5
    end
  end

  context "integer argument" do
    subject { CrystalApi::Variant.new("#{attribute}" => 5) }

    it "parses as integer" do
      subject.send(attribute).should == 5
    end
  end
end

shared_examples_for "string attribute" do
  context "string argument" do
    subject { CrystalApi::Variant.new("#{attribute}" => "str") }

    it "parses as string" do
      subject.send(attribute).should == "str"
    end
  end
end

shared_examples_for "boolean attribute" do
  context "argument 'true'" do
    subject { CrystalApi::Variant.new("#{attribute}" => "true") }

    it "parses as boolean" do
      subject.send(attribute).should == true
    end
  end

  context "argument 'false'" do
    subject { CrystalApi::Variant.new("#{attribute}" => "false") }

    it "parses as boolean" do
      subject.send(attribute).should == false
    end
  end

  context "argument '1'" do
    subject { CrystalApi::Variant.new("#{attribute}" => "1") }

    it "parses as boolean" do
      subject.send(attribute).should == true
    end
  end

  context "argument '0'" do
    subject { CrystalApi::Variant.new("#{attribute}" => "0") }

    it "parses as boolean" do
      subject.send(attribute).should == false
    end
  end

  context "argument true" do
    subject { CrystalApi::Variant.new("#{attribute}" => true) }

    it "parses as boolean" do
      subject.send(attribute).should == true
    end
  end

  context "argument false" do
    subject { CrystalApi::Variant.new("#{attribute}" => false) }

    it "parses as boolean" do
      subject.send(attribute).should == false
    end
  end
end
