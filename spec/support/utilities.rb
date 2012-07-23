# Denne filen er en hjelpefil til Test. Alt som lages her importeres automatisk inn i test filene.
# Files in the spec/support directory are automatically included by RSpec


# Lager en metode for å teste tittel på siden.
def full_title(page_title)
  base_title = "Rykket's side"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end