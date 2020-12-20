require "./scrapper.rb"
require 'discordrb'

bot = Discordrb::Commands::CommandBot.new token: ARGV[0].to_s, prefix: '$'

def generateString(url)
    #puts url
    prices = Goclecd.getPrice(url.to_s)
    vendeurs = Goclecd.getWebSite(url.to_s)
    vendeurst = [vendeurs[0], vendeurs[2], vendeurs[4]]
    avis = Goclecd.getWebSite(url.to_s)
    avist = [avis[1], avis[3], avis[5]]
    i = 0
    string = Array.new
    reponse = "Nous trouvons ce jeu: \n"
    prices.each do |p|
        reponse += "    :arrow_right: sur **#{vendeurst[i].to_s}** avec *#{avist[i].to_s}* pour `#{prices[i].to_s}`**€** \n"
        i+=1
    end
    return reponse
end

bot.command :price do |_event, *args|
    # Again, the return value of the block is sent to the channel
    # generateString("https://www.goclecd.fr/acheter-" + args.join("-")+"/").each do |s|
    #     _event.channel.send(s)
    # end
    generateString("https://www.goclecd.fr/acheter-" + args.join("-") + "-cle-cd-comparateur-prix"+"/")
end
bot.run
