EasyPost.api_key = 'k8LhxS1R58Dfmm3JUmciBQ'

FROM_ADDRESS = EasyPost::Address.create(
  :company => 'The Iron Tome',
  :street1 => '101 S Garland Ave',
  :street2 => '#104',
  :city => 'Orlando',
  :state => 'FL',
  :zip => '32801'
)