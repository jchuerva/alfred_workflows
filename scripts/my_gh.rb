VALUES = {
  'base_url' => 'https://github.com',
  'gh' => 'github',
  'iam' => 'ecosystem-iam',
  'apps' => 'ecosystem-apps',
  'qa' => 'quality',
  'gear' => 'gear',
  'jc' => 'jchuerva',
  "i" => "issues",
  'pr' => 'pulls',
  'me' => 'MetricFromGitHubProject',
  'iam_project_url' => '/orgs/github/projects/152',
  'apps_project_url' => '/orgs/github/projects/565'
}.freeze

DIRECT_LINKS = {
  'o' => 'https://octobox.githubapp.com/?reason=',
  'm' => 'https://mail.google.com/mail/u/0/#inbox',
  'f' => 'https://janky.githubapp.com/flakes/candidates',
  'ar' => 'https://github.com/github/github/blob/master/docs/areas-of-responsibility.yaml',
  '1:1' => 'https://docs.google.com/document/d/1SN32_YgEi96sN_3UgoSWskzq5quI1r_epxbNjR0InNE/edit#heading=h.q8rao69mifvu'
}.freeze

def build_url(input)
  return DIRECT_LINKS[input[0]] if DIRECT_LINKS.keys.include?(input[0]) 

  url = VALUES['base_url']
  url += '/github' unless ['jchuerva','jc'].include?(input[0])

  input.each do |item|
    url += VALUES[item].nil? ? "/#{item}" : "/#{VALUES[item]}"
  end

  if input[-1] == 'p'
    case input[-2]
    when 'iam'
      url = VALUES['base_url'] + VALUES['iam_project_url']
    when 'apps'
      url = VALUES['base_url'] + VALUES['apps_project_url']
    end
  end

  url
end

begin
  input = ARGV
  input_array = input.first.split

  exit if ['noti', 'ini'].include?(input_array[0])

  puts build_url(input)
  system('open', build_url(input_array))
end