require 'spec_helper'

describe CrystalApi::Product do
  describe ".from_json" do
    let(:json_hash) {{
      'product' => {
        "_embedded" => {
          "category" => {
            "category" => { "name" => "Zendikar" }
          },
          "market_prices" => {
            "market_prices" => {
              "high_market_price" => { "money" => { "cents" => 624, "currency" => "USD" } },
              "low_market_price" => { "money" => { "cents" => 553, "currency" => "USD" } },
              "market_price" => { "money" => { "cents" => 567, "currency" => "USD" } }
            }
          },
          "variants" => [
            { "variant" => { "id" => 1} },
            { "variant" => { "id" => 2} }
          ]
        },
        "min_sell_price" => {
          "money" => {
            "cents" => 999,
            "currency" => "USD"
          }
        },
        "qty" => 4,
        "name" => "Example Product",
        "catalog_links" => {
          "en" => {
            "href" => "http://bluetest.crystalcommerce.com/catalog/example_category-example_product_category/example_product/385"
          }
        },
        "available_on" => "2012-10-13",
        "base_sell_price" => {
          "money" => {
            "cents" => 999,
            "currency" => "USD"
          }
        },
        "base_buy_price" => {
          "money" => {
            "cents" => 500,
            "currency" => "USD"
          }
        },
        "max_buy_price" => {
          "money" => {
            "cents" => 500,
            "currency" => "USD"
          }
        },
        "photos" => [
          {
            "photo" => {
              "urls" => {
                "original" => {
                  "href" => "http://client-cdn.crystalcommerce.com/photo/bluetest/file/31417/smiley.jpg"
                }
              },
              "is_default" => true
            }
          }
        ],
        "max_sell_price" => {
          "money" => {
            "cents" => 999,
            "currency" => "USD"
          }
        },
        "updated_at" => "2012-06-05T16:32:16-07:00",
        "catalog_id" => 55678,
        "_links" => {
          "category" => {
            "href" => "/v1/categories/23"
          },
          "self" => {
            "href" => "/v1/products/385"
          },
          "related_products" => {
            "href" => "/v1/products/385/related"
          }
        },
        "is_preorder" => false,
        "msrp" => {
          "money" => {
            "cents" => 0,
            "currency" => "USD"
          }
        },
        "weight" => 1,
        "possible_variants_count" => 0,
        "related_tag_list" => [
          "!Example Product"
        ],
        "id" => 385,
        "descriptors" => [
          {
            "product_descriptor" => {
              "name" => "Color",
              "value" => "Green"
            }
          },
          {
            "product_descriptor" => {
              "name" => "Flavor Text",
              "value" => ""
            }
          }
        ],
        "is_domestic_only" => false,
        "is_buying" => false,
        "wtb_qty" => 0,
        "variant_dimensions" => ["Condition", "Language"],
        "tag_list" => [
          "!Example Product"
        ],
        "min_buy_price" => {
          "money" => {
            "cents" => 500,
            "currency" => "USD"
          }
        },
        "is_selling" => true,
        "description" => "example description",
        "default_variant" => {
          "variant" => { "id" => 1 }
        },
        "buylist_links" => {
          "en" => {
            "href" => "http://bluetest.crystalcommerce.com/buylist/example_category-example_product_category/example_product/385"
          }
        },
        "seoname" => "example_product"
      } 
    }}

    subject { CrystalApi::Product.from_json(json_hash) }

    its(:id) { should == 385 }
    its(:catalog_id) { should == 55678 }
    its(:weight) { should == 1.0 }
    its(:name) { should == "Example Product" }
    its(:seoname) { should == "example_product" }
    its(:description) { should == "example description" }
    its(:qty) { should == 4 }
    its(:wtb_qty) { should == 0 }

    its(:is_buying)        { should == false }
    its(:buying?)          { should == false }
    its(:is_selling)       { should == true }
    its(:selling?)         { should == true }
    its(:is_domestic_only) { should == false }
    its(:domestic_only?)   { should == false }
    its(:is_preorder)     { should == false }
    its(:preorder?)        { should == false }

    its(:msrp) { should == Money.new(0) }
    its(:base_sell_price) { should == Money.new(999) }
    its(:base_buy_price) { should == Money.new(500) }
    its(:min_sell_price) { should == Money.new(999) }
    its(:max_sell_price) { should == Money.new(999) }
    its(:min_buy_price) { should == Money.new(500) }
    its(:max_buy_price) { should == Money.new(500) }

    its(:updated_at) { should == DateTime.new(2012,6,5,16,32,16, Rational(-7,24)) }
    its(:available_on) { should == Date.new(2012, 10, 13) }

    its(:default_variant) { should == CrystalApi::Variant.new(id: 1) }

    its(:related_tag_list) { should == ["!Example Product"] }
    its(:tag_list) { should == ["!Example Product"] }

    its(:variant_dimensions) { should == ["Condition", "Language"] }

    its(:photos) { should == [
      CrystalApi::Photo.new(is_default: true,
        urls: {"original" => {href: "http://client-cdn.crystalcommerce.com/photo/bluetest/file/31417/smiley.jpg"}})
    ]}

    its(:descriptors) { should == [
      CrystalApi::ProductDescriptor.new(name: "Color", value: "Green"),
      CrystalApi::ProductDescriptor.new(name: "Flavor Text", value: "")
    ]}

    its(:catalog_links) { should == {
      "en" => CrystalApi::Url.new(href: "http://bluetest.crystalcommerce.com/catalog/example_category-example_product_category/example_product/385")
    }}

    its(:buylist_links) { should == {
      "en" => CrystalApi::Url.new(href: "http://bluetest.crystalcommerce.com/buylist/example_category-example_product_category/example_product/385")
    }}

    its(:category) { should == CrystalApi::Category.new(name: "Zendikar")}

    its(:variants) { should == [
      CrystalApi::Variant.new(id: 1),
      CrystalApi::Variant.new(id: 2)
    ]}

    its(:market_prices) {
      should == CrystalApi::MarketPrices.new(high_market_price: Money.new(624),
                                             low_market_price: Money.new(553),
                                             market_price: Money.new(567))
    }
  end
end
