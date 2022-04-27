const router = require('express-promise-router')();

const users = require('../controllers/users');
const {circuit, add_circuit, del_circuit} = require('../controllers/circuit')
const {abonnee, add_abonnee,verify_mdp} = require('../controllers/users');
const {competition, add_competition, del_competition, inscription, inscrit, del_inscrit} = require('../controllers/competition')




router.route('/users')
    .get(abonnee);
router.route(`/users/add_abonnee/:nom/:email/:mdp/:prenom`)
    .get(add_abonnee)
router.route('/users/verify_mdp/:email/:mdp')
    .get(verify_mdp);

router.route('/circuit')
    .get(circuit);
router.route('/circuit/add_circuit')
    .get(add_circuit)
router.route('/circuit/del_circuit/:id')
    .get(del_circuit)

router.route('/competition')
    .get(competition);
router.route('/competition/add_competition/:circuit/:date/:heure/:en_cours/:tour/:nomcompetition')
    .get(add_competition);
router.route('/competition/del_competition/:id')
    .get(del_competition);
router.route('/competition/inscription/:id/:idcompetition')
    .get(inscription);
router.route('/competition/inscrit/:idcompetition')
    .get(inscrit);
router.route('/competition/del_inscrit/:idcompetition/:iduser')
    .get(del_inscrit);

module.exports = router;