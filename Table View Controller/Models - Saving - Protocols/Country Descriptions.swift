//
//  Constants.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import Foundation

struct EuDescriptions {
	func getEuStatus(for countryName: String) -> Bool {
		
		switch countryName {
		case "greece":
			return true
		case "italy":
			return true
		case "austria":
			return true
		case "belgium":
			return true
		case "bulgaria":
			return true
		case "cyprus":
			return true
		case "denmark":
			return true
		case "estonia":
			return true
		case "finland":
			return true
		case "france":
			return true
		case "germany":
			return true
		case "hungary":
			return true
		case "ireland":
			return true
		case "spain":
			return true
		case "portugal":
			return true
		case "luxembourg":
			return true
		case "croatia":
			return true
		case "poland":
			return true
		case "romania":
			return true
		case "slovakia":
			return true
		case "malta":
			return true
		case "sweden":
			return true
		case "czech republic":
			return true
		case "netherlands":
			return true
		case "latvia":
			return true
		case "lithuania":
			return true
		case "slovenia":
			return true
		default:
			return false
		}
	}
}

struct CountryDescriptions {
	
	
	func getCountryDescription(for countryName: String) -> String {
		
		let countryName = countryName.lowercased()
		
		switch countryName {
		case "greece":
			return greece
		case "italy":
			return italy
		case "austria":
			return austria
		case "belgium":
			return belgium
		case "bulgaria":
			return bulgaria
		case "cyprus":
			return cyprus
		case "denmark":
			return denmark
		case "estonia":
			return estonia
		case "finland":
			return finland
		case "france":
			return france
		case "germany":
			return germany
		case "hungary":
			return hungary
		case "ireland":
			return ireland
		default:
			return "\(countryName) is a trully wonderful country."
		}
	}
	
	
	let greece = """
Greece, officially the Hellenic Republic, is a country in Southeast Europe. It is situated on the southern tip of the Balkan Peninsula, and is located at the crossroads of Europe, Asia, and Africa. Greece shares land borders with Albania to the northwest, North Macedonia and Bulgaria to the north, and Turkey to the northeast. The Aegean Sea lies to the east of the mainland, the Ionian Sea to the west, and the Sea of Crete and the Mediterranean Sea to the south. Greece has the longest coastline on the Mediterranean Basin, featuring thousands of islands. The country consists of nine traditional geographic regions, and has a population of approximately 10.4 million. Athens is the nation's capital and largest city, followed by Thessaloniki and Patras.
"""
	
	let italy = """
Italy (Italian: Italia), officially the Italian Republic, or the Republic of Italy, is a country in Southern and Western Europe. Located in the middle of the Mediterranean Sea and delimited by the Alps, its territory largely coincides with the homonymous geographical region. Italy shares land borders with France, Switzerland, Austria, Slovenia and the enclaved microstates of Vatican City and San Marino. It has a territorial exclave in Switzerland, Campione. Italy covers an area of 301,230 km2 (116,310 sq mi), with a population of about 60 million. It is the third-most populous member state of the European Union, the sixth-most populous country in Europe, and the tenth-largest country in the continent by land area. Italy's capital and largest city is Rome. Italy was the native place of many civilizations such as the Italic peoples and the Etruscans, while due to its central geographic location in Southern Europe and the Mediterranean, the country has also historically been home to myriad peoples and cultures, who immigrated to the peninsula throughout history. The Latins, native of central Italy, formed the Roman Kingdom in the 8th century BC, which eventually became a republic with a government of the Senate and the People. The Roman Republic initially conquered and assimilated its neighbours on the Italian peninsula, eventually expanding and conquering a large part of Europe, North Africa and Western Asia. By the first century BC, the Roman Empire emerged as the dominant power in the Mediterranean Basin and became a leading cultural, political and religious centre, inaugurating the Pax Romana, a period of more than 200 years during which Italy's law, technology, economy, art, and literature developed.

During the Early Middle Ages, Italy endured the fall of the Western Roman Empire and the Barbarian Invasions, but by the 11th century, numerous city-states and maritime republics, mostly in the North, became prosperous through trade, commerce, and banking, laying the groundwork for modern capitalism. The Renaissance began in Italy and spread to the rest of Europe, bringing a renewed interest in humanism, science, exploration, and art. During the Middle Ages, Italian explorers discovered new routes to the Far East and the New World, helping to usher in the European Age of Discovery. However, centuries of rivalry and infighting between the Italian city-states, and the invasions of other European powers during the Italian Wars of the 15th and 16th centuries, left Italy politically fragmented. Italy's commercial and political power significantly waned during the 17th and 18th centuries with the decline of the Catholic Church and the increasing importance of trade routes that bypassed the Mediterranean.
"""
	
	let austria = """
Austria, formally the Republic of Austria, is a country in the southern part of Central Europe, lying in the Eastern Alps. It is a federation of nine states, one of which is the capital, Vienna, the most populous city and state. A landlocked country, Austria is bordered by Germany to the northwest, the Czech Republic to the north, Slovakia to the northeast, Hungary to the east, Slovenia and Italy to the south, and Switzerland and Liechtenstein to the west. The country occupies an area of 83,871 km2 (32,383 sq mi) and has a population of 9 million. Austria emerged from the remnants of the Eastern and Hungarian March at the end of the first millennium. Originally a margraviate of Bavaria, it developed into a duchy of the Holy Roman Empire in 1156 and was later made an archduchy in 1453. In the 16th century, Vienna began serving as the empire's administrative capital and Austria thus became the heartland of the Habsburg monarchy. After the dissolution of the Holy Roman Empire in 1806, Austria established its own empire, which became a great power and the dominant member of the German Confederation. The empire's defeat in the Austro-Prussian War of 1866 led to the end of the Confederation and paved the way for the establishment of Austria-Hungary a year later.

After the assassination of Archduke Franz Ferdinand in 1914, Emperor Franz Joseph declared war on Serbia, which ultimately escalated into World War I. The empire's defeat and subsequent collapse led to the proclamation of the Republic of German-Austria in 1918 and the First Austrian Republic in 1919. During the interwar period, anti-parliamentarian sentiments culminated in the formation of an Austrofascist dictatorship under Engelbert Dollfuss in 1934. A year before the outbreak of World War II, Austria was annexed into Nazi Germany by Adolf Hitler, and it became a sub-national division. After its liberation in 1945 and a decade of Allied occupation, the country regained its sovereignty and declared its perpetual neutrality in 1955.
"""
	
	let belgium = """
Belgium, officially the Kingdom of Belgium, is a country in Northwestern Europe. The country is bordered by the Netherlands to the north, Germany to the east, Luxembourg to the southeast, France to the southwest, and the North Sea to the northwest. It covers an area of 30,528 km2 (11,787 sq mi) and has a population of more than 11.5 million, making it the 22nd most densely populated country in the world and the 6th most densely populated country in Europe, with a density of 376/km2 (970/sq mi). Belgium is part of an area known as the Low Countries, historically a somewhat larger region than the Benelux group of states, as it also included parts of northern France. The capital and largest city is Brussels; other major cities are Antwerp, Ghent, Charleroi, Liège, Bruges, Namur, and Leuven.

Belgium is a sovereign state and a federal constitutional monarchy with a parliamentary system. Its institutional organization is complex and is structured on both regional and linguistic grounds. It is divided into three highly autonomous regions: the Flemish Region (Flanders) in the north, the Walloon Region (Wallonia) in the south, and the Brussels-Capital Region. Brussels is the smallest and most densely populated region, as well as the richest region in terms of GDP per capita. Belgium is also home to two main linguistic communities: the Flemish Community, which constitutes about 60 percent of the population, and the French Community, which constitutes about 40 percent of the population. A small German-speaking Community, numbering around one percent, exists in the East Cantons. The Brussels-Capital Region is officially bilingual in French and Dutch, although French is the dominant language. Belgium's linguistic diversity and related political conflicts are reflected in its complex system of governance, made up of six different governments.

Since the Middle Ages, Belgium's central location near several major rivers has meant that the area has been relatively prosperous, connected commercially and politically to its bigger neighbours. The country as it exists today was established following the 1830 Belgian Revolution, when it seceded from the United Kingdom of the Netherlands, which had incorporated the Southern Netherlands (which comprised most of modern-day Belgium) after the Congress of Vienna in 1815. The name chosen for the new state is derived from the Latin word Belgium, used in Julius Caesar's "Gallic Wars", to describe a nearby region in the period around 55 BCE. Belgium has also been the battleground of European powers, earning the moniker the "Battlefield of Europe", a reputation reinforced in the 20th century by both world wars.
"""
	
	let bulgaria = """
Bulgaria; Bulgarian: България, romanized: Bǎlgariya), officially the Republic of Bulgaria (Bulgarian: Реnубʌиkа Бъʌƨаpия), is a country in Southeast Europe. It is situated on the eastern flank of the Balkans, and is bordered by Romania to the north, Serbia and North Macedonia to the west, Greece and Turkey to the south, and the Black Sea to the east. Bulgaria covers a territory of 110,994 square kilometres (42,855 sq mi), and is the sixteenth-largest country in Europe. Sofia is the nation's capital and largest city; other major cities are Plovdiv, Varna and Burgas.

One of the earliest societies in the lands of modern-day Bulgaria was the Neolithic Karanovo culture, which dates back to 6,500 BC. In the 6th to 3rd century BC the region was a battleground for ancient Thracians, Persians, Celts and Macedonians; stability came when the Roman Empire conquered the region in AD 45. After the Roman state splintered, tribal invasions in the region resumed. Around the 6th century, these territories were settled by the early Slavs. The Bulgars, led by Asparuh, attacked from the lands of Old Great Bulgaria and permanently invaded the Balkans in the late 7th century. They established First Bulgarian Empire, victoriously recognised by treaty in 681 AD by the Eastern Roman Empire. It dominated most of the Balkans and significantly influenced Slavic cultures by developing the Cyrillic script. The First Bulgarian Empire lasted until the early 11th century, when Byzantine emperor Basil II conquered and dismantled it. A successful Bulgarian revolt in 1185 established a Second Bulgarian Empire, which reached its apex under Ivan Asen II (1218–1241). After numerous exhausting wars and feudal strife, the empire disintegrated and in 1396 fell under Ottoman rule for nearly five centuries.

The Russo-Turkish War of 1877–78 resulted in the formation of the third and current Bulgarian state. Many ethnic Bulgarians were left outside the new nation's borders, which stoked irredentist sentiments that led to several conflicts with its neighbours and alliances with Germany in both world wars. In 1946, Bulgaria came under the Soviet-led Eastern Bloc and became a socialist state. The ruling Communist Party gave up its monopoly on power after the revolutions of 1989 and allowed multiparty elections. Bulgaria then transitioned into a democracy and a market-based economy. Since adopting a democratic constitution in 1991, Bulgaria has been a unitary parliamentary republic composed of 28 provinces, with a high degree of political, administrative, and economic centralisation.
"""
	let cyprus = """
Cyprus, officially the Republic of Cyprus, is an island country located south of the Anatolian Peninsula in the eastern Mediterranean Sea. Its continental position is disputed; while it is geographically in Western Asia, its cultural ties and geopolitics are overwhelmingly Southeastern European. Cyprus is the third-largest and third-most populous island in the Mediterranean. It is located north of Egypt, east of Greece, south of Turkey, and west of Lebanon and Syria. Its capital and largest city is Nicosia. The northeast portion of the island is de facto governed by the self-declared Turkish Republic of Northern Cyprus, which was established after the 1974 invasion and which is recognised as a country only by Turkey.

The earliest known human activity on the island dates to around the 10th millennium BC. Archaeological remains include the well-preserved ruins from the Hellenistic period such as Salamis and Kourion, and Cyprus is home to some of the oldest water wells in the world. Cyprus was settled by Mycenaean Greeks in two waves in the 2nd millennium BC. As a strategic location in the Eastern Mediterranean, it was subsequently occupied by several major powers, including the empires of the Assyrians, Egyptians and Persians, from whom the island was seized in 333 BC by Alexander the Great. Subsequent rule by Ptolemaic Egypt, the Classical and Eastern Roman Empire, Arab caliphates for a short period, the French Lusignan dynasty and the Venetians was followed by over three centuries of Ottoman rule between 1571 and 1878 (de jure until 1914).

Cyprus was placed under the United Kingdom's administration based on the Cyprus Convention in 1878 and was formally annexed by the UK in 1914. The future of the island became a matter of disagreement between the two prominent ethnic communities, Greek Cypriots, who made up 77% of the population in 1960, and Turkish Cypriots, who made up 18% of the population. From the 19th century onwards, the Greek Cypriot population pursued enosis, union with Greece, which became a Greek national policy in the 1950s. The Turkish Cypriot population initially advocated the continuation of the British rule, then demanded the annexation of the island to Turkey, and in the 1950s, together with Turkey, established a policy of taksim, the partition of Cyprus and the creation of a Turkish polity in the north.
"""
	
	let denmark = """
Denmark (Danish: Danmark, pronounced [ˈtænmɑk] (listen)) is a Nordic country in Northern Europe. It is the most populous and politically central constituent of the Kingdom of Denmark,[N 10] a constitutionally unitary state that includes the autonomous territories of the Faroe Islands and Greenland in the North Atlantic Ocean. Metropolitan Denmark[N 3] is the southernmost of the Scandinavian countries, lying south-west of Sweden, south of Norway,[N 11] and north of Germany.

As of 2013, the Kingdom of Denmark, including the Faroe Islands and Greenland, has a total of 1,419 islands above 100 square metres (1,100 sq ft); 443 of which have been named and of which 78 are inhabited.[16] Spanning a total area of 42,943 km2 (16,580 sq mi), metropolitan Denmark consists of the northern part of the Jutland peninsula and an archipelago of 406 islands.[17] Of these, the most populated island is Zealand, on which the capital Copenhagen is situated, followed by Funen, the North Jutlandic Island, and Amager.[18] Denmark's geography is characterised by flat, arable land, sandy coasts, low elevation, and a temperate climate. As of 2022, it had a population of 5.928 million (1 October 2022), of which 800,000 live in the capital and largest city, Copenhagen. Denmark exercises hegemonic influence in the Danish Realm, devolving powers to handle internal affairs. Home rule was established in the Faroe Islands in 1948 and in Greenland in 1979; the latter obtained further autonomy in 2009.

The unified Kingdom of Denmark emerged in the eighth century as a proficient maritime power amid the struggle for control of the Baltic Sea. In 1397, it joined Norway and Sweden to form the Kalmar Union, which persisted until the latter's secession in 1523. The remaining Kingdom of Denmark–Norway endured a series of wars in the 17th century that resulted in further territorial cessions to the Swedish Empire. Following the Napoleonic Wars, Norway was absorbed into Sweden, leaving Denmark with the Faroe Islands, Greenland, and Iceland. A surge of nationalist movements in the 19th century were defeated in the First Schleswig War of 1848, though the Second Schleswig War of 1864 resulted in further territorial losses to Prussia. The period saw the adoption of the Constitution of Denmark on 5 June 1849, ending the absolute monarchy that was established in 1660 and introducing the current parliamentary system.
"""
	
	let estonia = """
Estonia, formally the Republic of Estonia, is a country by the Baltic Sea in Northern Europe. It is bordered to the north by the Gulf of Finland across from Finland, to the west by the sea across from Sweden, to the south by Latvia, and to the east by Lake Peipus and Russia. The territory of Estonia consists of the mainland, the larger islands of Saaremaa and Hiiumaa, and over 2,200 other islands and islets on the eastern coast of the Baltic Sea, covering a total area of 45,339 square kilometres (17,505 sq mi). The capital city Tallinn and Tartu are the two largest urban areas of the country. The Estonian language is the autochthonous and the official language of Estonia; it is the first language of the majority of its population, as well as the world's second most spoken Finnic language.

The land of what is now modern Estonia has been inhabited by Homo sapiens since at least 9,000 BC. The medieval indigenous population of Estonia was one of the last "pagan" civilisations in Europe to adopt Christianity following the Papal-sanctioned Livonian Crusade in the 13th century. After centuries of successive rule by the Teutonic Order, Denmark, Sweden, and the Russian Empire, a distinct Estonian national identity began to emerge in the mid-19th century. This culminated in the 24 February 1918 Estonian Declaration of Independence from the then warring Russian and German Empires. After the end of World War I, in the 1918–1920 War of Independence, Estonians were able to repel the Bolshevik Russian invasion and successfully defended their newborn freedom. Democratic throughout most of the interwar period, Estonia declared neutrality at the outbreak of World War II, but the country was repeatedly contested, invaded and occupied, first by Stalinist Soviet Union in 1940, then by Nazi Germany in 1941, and ultimately reoccupied in 1944 by, and annexed into, the USSR as an administrative subunit (Estonian SSR). After the loss of its de facto independence to the Soviet Union, Estonia's de jure state continuity was preserved by diplomatic representatives and the government-in-exile. Following the bloodless Estonian "Singing Revolution" of 1988–1990, the nation's de facto independence was restored on 20 August 1991.

Estonia is a developed country, with a high-income advanced economy, ranking very highly in the Human Development Index. The sovereign state of Estonia is a democratic unitary parliamentary republic, administratively subdivided into 15 maakond (counties). With a population of just over 1.3 million, it is one of the least populous members of the European Union, the Eurozone, the OECD, the Schengen Area, and NATO. Estonia is nowadays often considered to be one of the three "Baltic countries" or "Baltic states" — a geopolitical grouping which also includes Latvia and Lithuania. Estonia has consistently ranked highly in international rankings for quality of life, education, press freedom, digitalisation of public services and the prevalence of technology companies.
"""
	
	let finland = """
Finland (Finnish: Suomi [ˈsuo̯mi] ; Swedish: Finland [ˈfɪ̌nland] (listen)), officially the Republic of Finland (Finnish: Suomen tasavalta; Swedish: Republiken Finland (listen to all)), is a Nordic country in Northern Europe. It shares land borders with Sweden to the northwest, Norway to the north, and Russia to the east, with the Gulf of Bothnia to the west and the Gulf of Finland to the south, across from Estonia. Finland covers an area of 338,455 square kilometres (130,678 sq mi) with a population of 5.6 million. Helsinki is the capital and largest city. The vast majority of the population are ethnic Finns. Finnish and Swedish are the official languages, Swedish is the native language of 5.2% of the population. Finland's climate varies from humid continental in the south to the boreal in the north. The land cover is primarily a boreal forest biome, with more than 180,000 recorded lakes.

Finland was first inhabited around 9000 BC after the Last Glacial Period. The Stone Age introduced several different ceramic styles and cultures. The Bronze Age and Iron Age were characterized by contacts with other cultures in Fennoscandia and the Baltic region. From the late 13th century, Finland became a part of Sweden as a consequence of the Northern Crusades. In 1809, as a result of the Finnish War, Finland became part of the Russian Empire as the autonomous Grand Duchy of Finland, during which Finnish art flourished and the idea of independence began to take hold. In 1906, Finland became the first European state to grant universal suffrage, and the first in the world to give all adult citizens the right to run for public office. After the 1917 Russian Revolution, Finland declared independence from Russia. In 1918, the fledgling state was divided by the Finnish Civil War. During World War II, Finland fought the Soviet Union in the Winter War and the Continuation War, and Nazi Germany in the Lapland War. It subsequently lost parts of its territory, but maintained its independence.

Finland largely remained an agrarian country until the 1950s. After World War II, it rapidly industrialized and developed an advanced economy, while building an extensive welfare state based on the Nordic model; the country soon enjoyed widespread prosperity and a high per capita income. During the Cold War, Finland adopted an official policy of neutrality. Finland joined the European Union in 1995 and the Eurozone at its inception in 1999. Finland is a top performer in numerous metrics of national performance, including education, economic competitiveness, civil liberties, quality of life and human development. In 2015, Finland ranked first in the World Human Capital, topped the Press Freedom Index, and was the most stable country in the world during 2011–2016, according to the Fragile States Index; it is second in the Global Gender Gap Report, and has ranked first in every annual World Happiness Report since 2018.
"""
	
	let france = """
France (French: [fʁɑ̃s]), officially the French Republic (French: République française [ʁepyblik frɑ̃sɛz]), is a country primarily located in Western Europe. It also comprises of overseas regions and territories in the Americas and the Atlantic, Pacific and Indian Oceans. Its metropolitan area extends from the Rhine to the Atlantic Ocean and from the Mediterranean Sea to the English Channel and the North Sea; overseas territories include French Guiana in South America, Saint Pierre and Miquelon in the North Atlantic, the French West Indies, and many islands in Oceania and the Indian Ocean. Due to its several coastal territories, France has the largest exclusive economic zone in the world. France borders Belgium, Luxembourg, Germany, Switzerland, Monaco, Italy, Andorra, and Spain in continental Europe, as well as the Netherlands, Suriname, and Brazil in the Americas via its overseas territories in French Guiana and Saint Martin. Its eighteen integral regions (five of which are overseas) span a combined area of 643,801 km2 (248,573 sq mi) and contain close to 68 million people (as of July 2022). France is a unitary semi-presidential republic with its capital in Paris, the country's largest city and main cultural and commercial centre; other major urban areas include Marseille, Lyon, Toulouse, Lille, Bordeaux, and Nice.

Inhabited since the Palaeolithic era, the territory of Metropolitan France was settled by Celtic tribes known as Gauls during the Iron Age. Rome annexed the area in 51 BC, leading to a distinct Gallo-Roman culture that laid the foundation of the French language. The Germanic Franks formed the Kingdom of Francia, which became the heartland of the Carolingian Empire. The Treaty of Verdun of 843 partitioned the empire, with West Francia becoming the Kingdom of France in 987. In the High Middle Ages, France was a powerful but highly decentralised feudal kingdom. Philip II successfully strengthened royal power and defeated his rivals to double the size of the crown lands; by the end of his reign, France had emerged as the most powerful state in Europe. From the mid-14th to the mid-15th century, France was plunged into a series of dynastic conflicts involving England, collectively known as the Hundred Years' War, and a distinct French identity emerged as a result. The French Renaissance saw art and culture flourish, conflict with the House of Habsburg, and the establishment of a global colonial empire, which by the 20th century would become the second-largest in the world. The second half of the 16th century was dominated by religious civil wars between Catholics and Huguenots that severely weakened the country. France again emerged as Europe's dominant power in the 17th century under Louis XIV following the Thirty Years' War. Inadequate economic policies, inequitable taxes and frequent wars (notably a defeat in the Seven Years' War and costly involvement in the American War of Independence) left the kingdom in a precarious economic situation by the end of the 18th century. This precipitated the French Revolution of 1789, which overthrew the Ancien Régime and produced the Declaration of the Rights of Man, which expresses the nation's ideals to this day.
"""
	
	let germany = """
Germany, officially the Federal Republic of Germany, is a country in Central Europe. It is the second most populous country in Europe after Russia, and the most populous member state of the European Union. Germany is situated between the Baltic and North seas to the north, and the Alps to the south; it covers an area of 357,022 square kilometres (137,847 sq mi), with a population of almost 84 million within its 16 constituent states. Germany borders Denmark to the north, Poland and the Czech Republic to the east, Austria and Switzerland to the south, and France, Luxembourg, Belgium, and the Netherlands to the west. The nation's capital and most populous city is Berlin and its financial centre is Frankfurt; the largest urban area is the Ruhr.

Various Germanic tribes have inhabited the northern parts of modern Germany since classical antiquity. A region named Germania was documented before AD 100. In 962, the Kingdom of Germany formed the bulk of the Holy Roman Empire. During the 16th century, northern German regions became the centre of the Protestant Reformation. Following the Napoleonic Wars and the dissolution of the Holy Roman Empire in 1806, the German Confederation was formed in 1815.

Formal unification of Germany into the modern nation-state was commenced on 18 August 1866 with the North German Confederation Treaty establishing the Prussia-led North German Confederation later transformed in 1871 into the German Empire. After World War I and the German Revolution of 1918–1919, the Empire was in turn transformed into the semi-presidential Weimar Republic. The Nazi seizure of power in 1933 led to the establishment of a totalitarian dictatorship, World War II, and the Holocaust. After the end of World War II in Europe and a period of Allied occupation, in 1949, Germany as a whole was organized into two separate polities with limited sovereignity: the Federal Republic of Germany, generally known as West Germany, and the German Democratic Republic, East Germany, while Berlin de jure continued its Four Power status. The Federal Republic of Germany was a founding member of the European Economic Community and the European Union, while the German Democratic Republic was a communist Eastern Bloc state and member of the Warsaw Pact. After the fall of communist led-government in East Germany, German reunification saw the former East German states join the Federal Republic of Germany on 3 October 1990—becoming a federal parliamentary republic.

Germany is a great power with a strong economy; it has the largest economy in Europe, the world's fourth-largest economy by nominal GDP and the fifth-largest by PPP. As a global power in industrial, scientific and technological sectors, it is both the world's third-largest exporter and importer. As a highly developed country, which ranks ninth on the Human Development Index, it offers social security and a universal health care system, environmental protections, a tuition-free university education, and it is ranked as sixteenth-most peaceful country in the world. Germany is a member of the United Nations, the European Union, NATO, the Council of Europe, the G7, the G20 and the OECD. It has the third-greatest number of UNESCO World Heritage Sites.
"""
	
	let hungary = """
Hungary (Hungarian: Magyarország [ˈmɒɟɒrorsaːɡ]) is a landlocked country in Central Europe. Spanning 93,030 square kilometres (35,920 sq mi) of the Carpathian Basin, it is bordered by Slovakia to the north, Ukraine to the northeast, Romania to the east and southeast, Serbia to the south, Croatia and Slovenia to the southwest, and Austria to the west. Hungary has a population of 9.7 million, mostly ethnic Hungarians and a significant Romani minority. Hungarian, the official language, is the world's most widely spoken Uralic language and among the few non-Indo-European languages widely spoken in Europe. Budapest is the country's capital and largest city; other major urban areas include Debrecen, Szeged, Miskolc, Pécs, and Győr.

The territory of present-day Hungary has for centuries been a crossroads for various peoples, including Celts, Romans, Germanic tribes, Huns, West Slavs and the Avars. The foundation of the Hungarian state was established in the late 9th century AD with the conquest of the Carpathian Basin by Hungarian grand prince Árpád. His great-grandson Stephen I ascended the throne in 1000, converting his realm to a Christian kingdom. By the 12th century, Hungary became a regional power, reaching its cultural and political height in the 15th century. Following the Battle of Mohács in 1526, it was partially occupied by the Ottoman Empire (1541–1699). Hungary came under Habsburg rule at the turn of the 18th century, later joining with the Austrian Empire to form Austria-Hungary, a major power into the early 20th century.

Austria-Hungary collapsed after World War I, and the subsequent Treaty of Trianon established Hungary's current borders, resulting in the loss of 71% of its territory, 58% of its population, and 32% of ethnic Hungarians. Following the tumultuous interwar period, Hungary joined the Axis powers in World War II, suffering significant damage and casualties. Postwar Hungary became a satellite state of the Soviet Union, leading to the establishment of the Hungarian People's Republic. Following the failed 1956 revolution, Hungary became a comparatively freer, though still repressed, member of the Eastern Bloc. The removal of Hungary's border fence with Austria accelerated the collapse of the Eastern Bloc and subsequently the Soviet Union. On 23 October 1989, Hungary again became a democratic parliamentary republic. Hungary joined the European Union in 2004 and has been part of the Schengen Area since 2007.
"""
	
	let ireland = """
Ireland (/ˈaɪərlənd/); Irish: Éire [ˈeːɾʲə] is an island in the North Atlantic Ocean, in north-western Europe. It is separated from Great Britain to its east by the North Channel, the Irish Sea, and St George's Channel. Ireland is the second-largest island of the British Isles, the third-largest in Europe, and the twentieth-largest on Earth.

Geopolitically, Ireland is divided between the Republic of Ireland (officially named Ireland), which covers five-sixths of the island, and Northern Ireland, which is part of the United Kingdom. As of 2022, the population of the entire island is just over 7 million, with 5.1 million living in the Republic of Ireland and 1.9 million in Northern Ireland, ranking it the second-most populous island in Europe after Great Britain.

The geography of Ireland comprises relatively low-lying mountains surrounding a central plain, with several navigable rivers extending inland. Its lush vegetation is a product of its mild but changeable climate which is free of extremes in temperature. Much of Ireland was woodland until the end of the Middle Ages. Today, woodland makes up about 10% of the island, compared with a European average of over 33%, with most of it being non-native conifer plantations. The Irish climate is influenced by the Atlantic Ocean and thus very moderate, and winters are milder than expected for such a northerly area, although summers are cooler than those in continental Europe. Rainfall and cloud cover are abundant.

Gaelic Ireland had emerged by the 1st century AD. The island was Christianised from the 5th century onwards. Following the 12th century Anglo-Norman invasion, England claimed sovereignty. However, English rule did not extend over the whole island until the 16th–17th century Tudor conquest, which led to colonisation by settlers from Britain. In the 1690s, a system of Protestant English rule was designed to materially disadvantage the Catholic majority and Protestant dissenters, and was extended during the 18th century. With the Acts of Union in 1801, Ireland became a part of the United Kingdom. A war of independence in the early 20th century was followed by the partition of the island, leading to the creation of the Irish Free State, which became increasingly sovereign over the following decades, and Northern Ireland, which remained a part of the United Kingdom. Northern Ireland saw much civil unrest from the late 1960s until the 1990s. This subsided following the Good Friday Agreement in 1998. In 1973, the Republic of Ireland joined the European Economic Community while the United Kingdom, and Northern Ireland as part of it, did the same. In 2020, the United Kingdom, Northern Ireland included, left what was by then the European Union (EU).
"""
}
