const pool = require('../config/database');

module.exports = {

    abonnee: async (req, res, next) => {
        let connexion;
        try {   
            connexion = await pool.getConnection();
            const result = await connexion.query('Select * FROM abonnee;');
            console.log(result);
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json(error.message);
        } finally {
            if (connexion) connexion.end()
        }
    },
    add_abonnee: async (req, res, next) => {
        let connexion;
        try {
            connexion = await pool.getConnection();
            const nom = req.params.nom
            const email = req.params.email
            const mdp = req.params.mdp
            const prenom = req.params.prenom
            console.log('info', nom)
            const result = await connexion.query('CALL add_abonnee(NULL ,"'+nom+'", "'+email+'", "'+mdp+'", "'+prenom+'", 0)');
            console.log(result);
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json(error.message);
        } finally {
            if (connexion) connexion.end()
        }
    },
    verify_mdp: async(req, res, next) => 
    {
        let connexion;
        try
        {
            connexion = await pool.getConnection();
            const email = req.params.email;
            const mdp = req.params.mdp;
            const result = await connexion.query('CALL verify_mdp("'+email+'")');
            console.log(result[0][0].mdp);
            console.log(mdp, email);
        
            if(result[0][0].mdp === mdp){
                console.log('true');
                return res.status(200).send({"result": 'true', 'user': result[0][0]})
            }else{
                console.log('false');
                return res.status(200).send({"result": 'false'})
            }
            


            
        } catch (error) {
            return res.status(400).json(error.message);
        } finally {
            if (connexion) connexion.end()
        }
    },

}