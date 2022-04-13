const pool = require('../config/database');

module.exports = {

    competition: async (req, res, next) => {
        let connexion;
        try {
            connexion = await pool.getConnection();
            const result = await connexion.query('Select * FROM competition;');
            console.log(result);
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json({ error: error.message });
        } finally {
            if (connexion) connexion.end()
        }
    },
    add_competition: async (req, res, next) => {
        let connexion;
        try {
            connexion = await pool.getConnection();
            const circuit = req.params.circuit
            const date = req.params.date
            const heure = req.params.heure
            const en_cour = req.params.en_cour
            const tour = req.params.tour
            const nomcompetition = req.params.nomcompetition
            const result = await connexion.query(' CALL add_competition(NULL, "'+circuit+'", "'+date+'", "'+heure+'", "'+en_cour+'", "'+tour+'", "'+nomcompetition+'");');
            console.log(result);
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json(error.message);
        } finally {
            if (connexion) connexion.end()
        }
    },

    del_competition: async (req, res, next) => {
        let connexion;
        try {
            const id = parseInt(req.params.id)
            console.log('id',id)
            connexion = await pool.getConnection();
            const result = await connexion.query(' CALL del_competition('+id+');');
            console.log(result);
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json(error.message);
        } finally {
            if (connexion) connexion.end()
        }
    },
    inscription: async (req, res, next) => {
        let connexion;
        try {
            const id = parseInt(req.params.id)
            const idcompetition = parseInt(req.params.idcompetition)
            console.log('id',id)
            connexion = await pool.getConnection();
            const result = await connexion.query(' CALL inscription("'+id+'", "'+idcompetition+'");');
            console.log(result);
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json(error.message);
        } finally {
            if (connexion) connexion.end()
        }
    },




}