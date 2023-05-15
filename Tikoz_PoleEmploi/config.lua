Config = {}

Config.Pole = {

    Pos = vector3(-269.14, -955.64, 30.22),

    Id = 787, -- Vous pouvez changer le blip et la couleur avec : https://docs.fivem.net/docs/game-references/blips/
    
    Taille = 1.0,
    
    Couleur = 57,

    Nom = "Pole Emploi"

}

Config.Candidature = true -- Pour faire des candidatures depuis le menu = true, si vous ne voulez pas = false


Config.Pos = { 
    Ped = vector4(-269.14, -955.64, 30.22, 206.29), -- Position du pnj au pole emploie 
    Menu = vector3(-268.85, -956.44, 30.22) -- Position du menu 
}


-- Liste des jobs que vous pouvez faire sans entretien d'embauche
-- name = Le nom du bouton afficher dans le menu, job = le nom du job (comme pour un setjob), Message = Vous pouvez choisir d'afficher un notification quand vous cliquer sur le job

ListeNonWl = {  
    {name = "Jardinier", job = "jardinier", Message = "Vous êtes désormais ~b~jardinier"},
    {name = "Eboueur", job = "eboueur", Message = "Vous êtes désormais ~b~éboueur"},
    {name = "Raffineur", job = "raffineur", Message = "Vous êtes désormais ~b~raffineur"},
}


-- Liste des jobs au quels vous pouvez postuler
-- name = Le nom du bouton dans le menu, job = Le nom de votre job (comme pour un setjob), Message = Notification quand vous cliquer sur le bouton, webhook = Coller le lien du webhook que vous voulez pour chaque job


ListeWl = {
    {name = "Police", job = "police", Message = "Pour rejoindre la ~b~police~s~ veuillez rejoindre le discord : ~b~discord.gg/ydHc8nGbee", webhook = "https://discord.com/api/webhooks/1083858576633761914/YBwvRB_o-kTSJ_SuLRBAricBv3H2uC_qZcnEdsvSgkIJm9_sO_8z9it2oCy-4QTNgG3_"},
    {name = "Ambulance", job = "ambulance", Message = "Pour rejoindre les ~b~EMS~s~ veuillez rejoindre le discord : ~b~discord.gg/ydHc8nGbee", webhook = "https://discord.com/api/webhooks/1051852103586422824/ZXF3Rl-kUhOCL7YiUIuyLxOlMJ5N0eYr5IyIgCuw-IWLu9ZHRtNOnHPbYiR-B9--oBwP"},
    {name = "Mécano", job = "mechanic", Message = "Pour rejoindre les ~b~mécano~s~ veuillez rejoindre le discord : ~b~discord.gg/ydHc8nGbee", webhook = "https://discord.com/api/webhooks/1083858449160491019/YezXOWCrFlIztHz6M0ofeifbjlT_mhyFVcjRnDTU7XzlB3iVq-_7x7Evn072vsPpaWrH"},
}


-- Les menus où seront afficher les candidatures pour les jobs (il faut que le nom du job dans MenuJobPos soit le même que le job dans ListeWl au dessus)
-- job = Le nom du setjob, grade = le grade minimum du job qui peux accéder au menu, x y z = les coordonnés

MenuJobPos = {
    {job = "police", grade = 2, x = 441.11, y = -978.57, z = 29.69},
    {job = "mechanic", grade = 2, x = -206.11, y = -1331.57, z = 33.89}
}


-- Tout les blips pour les jobs intérimaire  

Blipjob = {
    {name = "Intérim | Raffineur", id = 436, Taille = 0.7, Couleur = 42, pos = vector3(2670.85, 1612.86, 23.5)},
    {name = "Intérim | Eboueur", id = 366, Taille = 0.7, Couleur = 42, pos = vector3(-337.86, -1533.61, 26.71)},
    {name = "Intérim | Jardinier", id = 351, Taille = 0.7, Couleur = 42, pos = vector3(-1349.91, 126.04, 26.71)}
}

-- ██████╗░░█████╗░███████╗███████╗██╗███╗░░██╗███████╗██╗░░░██╗██████╗░
-- ██╔══██╗██╔══██╗██╔════╝██╔════╝██║████╗░██║██╔════╝██║░░░██║██╔══██╗
-- ██████╔╝███████║█████╗░░█████╗░░██║██╔██╗██║█████╗░░██║░░░██║██████╔╝
-- ██╔══██╗██╔══██║██╔══╝░░██╔══╝░░██║██║╚████║██╔══╝░░██║░░░██║██╔══██╗
-- ██║░░██║██║░░██║██║░░░░░██║░░░░░██║██║░╚███║███████╗╚██████╔╝██║░░██║
-- ╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░╚═╝╚═╝░░╚══╝╚══════╝░╚═════╝░╚═╝░░╚═╝


Config.Raffineur = {

    Garage = vector3(2672.77, 1610.15, 23.5),
    
    SpawnCar = vector4(2685.55, 1611.18, 23.59, 7.52),

    DelCar = vector3(2685.55, 1611.18, 23.59),

    Vestiaire = vector3(2670.85, 1612.86, 23.5),

    Recolte = vector3(704.43, 2891.53, 49.19),

    Traitement = vector3(1709.02, -1658.0, 111.46),

    Vente = vector3(-2081.89, -319.86, 12.06)

}

Config.TenueRaffineur = {
	Homme = {
	['tshirt_1'] = 15, ['tshirt_2'] = 0,
	['torso_1'] = 65, ['torso_2'] = 0,
	['arms'] = 0,
	['pants_1'] = 38, ['pants_2'] = 0,
	['shoes_1'] = 25, ['shoes_2'] = 0,
    },

    Femme = {
        ['tshirt_1'] = 38,['tshirt_2'] = 0,
        ['torso_1'] = 57, ['torso_2'] = 0,
        ['arms'] = 21, ['arms_2'] = 0,
        ['pants_1'] = 11, ['pants_2'] = 1,
        ['shoes_1'] = 49, ['shoes_2'] = 0,
    }
}


-- ███████╗██████╗░░█████╗░██╗░░░██╗███████╗██╗░░░██╗██████╗░
-- ██╔════╝██╔══██╗██╔══██╗██║░░░██║██╔════╝██║░░░██║██╔══██╗
-- █████╗░░██████╦╝██║░░██║██║░░░██║█████╗░░██║░░░██║██████╔╝
-- ██╔══╝░░██╔══██╗██║░░██║██║░░░██║██╔══╝░░██║░░░██║██╔══██╗
-- ███████╗██████╦╝╚█████╔╝╚██████╔╝███████╗╚██████╔╝██║░░██║
-- ╚══════╝╚═════╝░░╚════╝░░╚═════╝░╚══════╝░╚═════╝░╚═╝░░╚═╝


Config.Eboueur = {

    Ped = vector4(-337.86, -1533.61, 26.71, 359.55),

    Menu = vector3(-337.86, -1532.49, 26.71),

    Vestiaire = vector3(-340.15, -1534.14, 26.71),

    Vehicule = "trash",

    SpawnVehicule = vector4(-331.4, -1525.32, 26.53, 271.1),

    DelVehicule = vector3(-331.4, -1525.32, 26.53),

    PayeMin = 5,

    PayeMax = 10

}

PositionPoubelle = {
    {x = -241.2524, y = -1471.922, z = 30.4928},
    {x = -57.04048, y = -1496.182, z = 30.68},
    {x = 95.55818, y = -1523.906, z = 28.34},
    {x = 437.4628, y = -1460.678, z = 28.29}
}

Config.BlipPoubelle = {

    UseBlip = true,

    Id = 128, -- Vous pouvez changer le blip et la couleur avec : https://docs.fivem.net/docs/game-references/blips/
    
    Taille = 0.7,
    
    Couleur = 47,

    Nom = "Poubelle"
}

Config.Tenueeboueur = {
	Homme = {
	['tshirt_1'] = 15, ['tshirt_2'] = 0,
	['torso_1'] = 65, ['torso_2'] = 0,
	['arms'] = 0,
	['pants_1'] = 38, ['pants_2'] = 0,
	['shoes_1'] = 25, ['shoes_2'] = 0,
    },

    Femme = {
        ['tshirt_1'] = 38,['tshirt_2'] = 0,
        ['torso_1'] = 57, ['torso_2'] = 0,
        ['arms'] = 21, ['arms_2'] = 0,
        ['pants_1'] = 11, ['pants_2'] = 1,
        ['shoes_1'] = 49, ['shoes_2'] = 0,
    }
}


-- ░░░░░██╗░█████╗░██████╗░██████╗░██╗███╗░░██╗██╗███████╗██████╗░
-- ░░░░░██║██╔══██╗██╔══██╗██╔══██╗██║████╗░██║██║██╔════╝██╔══██╗
-- ░░░░░██║███████║██████╔╝██║░░██║██║██╔██╗██║██║█████╗░░██████╔╝
-- ██╗░░██║██╔══██║██╔══██╗██║░░██║██║██║╚████║██║██╔══╝░░██╔══██╗
-- ╚█████╔╝██║░░██║██║░░██║██████╔╝██║██║░╚███║██║███████╗██║░░██║
-- ░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚═╝╚═╝░░╚══╝╚═╝╚══════╝╚═╝░░╚═╝


Config.Jardinier = {

    Ped = "s_m_m_dockwork_01",

    Pnj = vector4(-1349.88, 125.17, 55.24, 358.44),

    Menu = vector3(-1349.91, 126.04, 55.24),

    Vestiaire = vector3(-1353.82, 125.22, 55.24),

    Vehicule = "caddy",

    SpawnVehicule = vector4(-1349.93, 132.8, 55.25, 185.01),

    DelCar = vector3(-1349.93, 132.8, 55.25),

    PayeMin = 5,

    PayeMax = 10

}

Posfeuille = {
    {x = -1154.2, y = 33.75, z = 50.55},
    {x = -1125.16, y = -13.75, z = 48.15},
    {x = -1115.16, y = 42.75, z = 51.15},
    {x = -1058.81, y = 63.2, z = 50.17}
}

Config.Blip = {

    UseBlip = true,

    Id = 128, -- Vous pouvez changer le blip et la couleur avec : https://docs.fivem.net/docs/game-references/blips/
    
    Taille = 0.7,
    
    Couleur = 47,

    Nom = "Feuilles mortes"
}


Config.TenueJardinier = {
	Homme = {
	['tshirt_1'] = 15, ['tshirt_2'] = 0,
	['torso_1'] = 65, ['torso_2'] = 0,
	['arms'] = 0,
	['pants_1'] = 38, ['pants_2'] = 0,
	['shoes_1'] = 25, ['shoes_2'] = 0,
    },

    Femme = {
        ['tshirt_1'] = 38,['tshirt_2'] = 0,
        ['torso_1'] = 57, ['torso_2'] = 0,
        ['arms'] = 21, ['arms_2'] = 0,
        ['pants_1'] = 11, ['pants_2'] = 1,
        ['shoes_1'] = 49, ['shoes_2'] = 0,
    }
}

