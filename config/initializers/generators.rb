Rails.application.config.generators do |g|
  g.assets          false  # CSS/JSファイル生成せず
  g.resource_route  false  # routes.rbを変更せず
  g.helper          false  # ヘルパー生成せず
  g.test_framework :rspec,   # テストフレームワークはrspecを使用。テストデータだけ作成
    view_specs:       false,
    helper_specs:     false,
    routing_specs:    false,
    controller_specs: false,
    request_specs:    false,
    fixtures:          true
  g.fixture_replacement :factory_bot, dir: "spec/factories"  # fixtureはfactory_botでディレクトリを変更
end