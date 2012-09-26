
dep 'redis', :template => 'managed' do
  provides 'redis-cli'
end

dep 'pow' do
  met? {
    "~/Library/Application Support/Pow/Current".p.exists?
  }

  meet {
    log_shell "Installing Pow", "curl get.pow.cx | sh"
  }
end
