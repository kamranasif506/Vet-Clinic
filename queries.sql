/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT * FROM animals WHERE escape_attempts < 3 and neutered = true;
SELECT date_of_birth from animals where name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts from animals where weight_kg > 10.5;
SELECT * from animals where neutered = true;
SELECT * from animals where name NOT IN ('Gabumon');
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals
SET species = 'Unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'Digimon' WHERE name LIKE '%mon';
UPDATE animals
SET species = 'Pokemon' WHERE species IS NULL OR species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals

SELECT count(*) as total_animals FROM animals

SELECT count(*) as total_animals FROM animals WHERE escape_attempts < 1

SELECT AVG(weight_kg) AS average_weight FROM animals;

SELECT neutered, SUM(escape_attempts) AS total_escapes FROM animals GROUP BY neutered ORDER BY total_escapes DESC LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name as animal_name 
    FROM animals
    JOIN owners on animals.owner_id = owners.id
    WHERE owners.full_name = 'Melody Pond';

SELECT animals.name as animal_name, species.name as type 
    FROM animals
    JOIN species on animals.species_id = species.id
    WHERE species.name = 'Pokemon';

SELECT owners.full_name AS owner_name, animals.name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name;

SELECT s.name AS species_name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name
ORDER BY s.name;

SELECT animals.name as animal_name,species.name as type, owners.full_name as owner_id
FROM animals
inner join species on animals.species_id = species.id
inner join owners on animals.owner_id = owners.id
where species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell'

SELECT animals.name as animal_name
FROM animals
inner join owners on animals.owner_id = owners.id
where owners.full_name = 'Dean Winchester' and animals.escape_attempts < 1;

SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

select animals.name as animal, visits.date_of_visit as date_of_visit
 from animals
 left join visits on animals.id = visits.animal_id
 left join vets on vets.id = visits.vet_id
 where vets.name = 'William Tatcher' 
 ORDER BY date_of_visit DESC
 LIMIT 1; 

select animals.name as animal, visits.date_of_visit as date_of_visit
 from animals
 left join visits on animals.id = visits.animal_id
 left join vets on vets.id = visits.vet_id
 where vets.name = 'Stephanie Mendez';

SELECT vets.name as vet_name, species.name as speciality
from vets
left join specializations on vets.id = specializations.vet_id
left join species on specializations.species_id = species.id

select animals.name as animal, visits.date_of_visit as date_of_visit
 from animals
 left join visits on animals.id = visits.animal_id
 left join vets on vets.id = visits.vet_id
 where vets.name = 'Stephanie Mendez' 
 and date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
 
SELECT animals.name AS animal_name, COUNT(visits.id) AS visit_count
FROM animals
LEFT JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.id, animals.name
ORDER BY visit_count DESC
LIMIT 1;

select animals.name as animal, visits.date_of_visit as date_of_visit
 from animals
 left join visits on animals.id = visits.animal_id
 left join vets on vets.id = visits.vet_id
 where vets.name = 'Maisy Smith' ORDER BY date_of_visit ASC LIMIT 1;

 select animals.name as animal,vets.name as vet_name, visits.date_of_visit as date_of_visit
 from animals
 left join visits on animals.id = visits.animal_id
 left join vets on vets.id = visits.vet_id
 ORDER BY date_of_visit DESC LIMIT 1;

 SELECT COUNT(v.id) AS mismatched_specialization_visits
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.id IS NULL;

SELECT species.name AS suggested_specialty, COUNT(*) AS visit_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets on visits.vet_id = vets.id
JOIN species  ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.id, species.name
ORDER BY visit_count DESC
LIMIT 1;
