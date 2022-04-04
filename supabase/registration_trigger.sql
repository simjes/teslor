CREATE OR REPLACE FUNCTION add_car()
RETURNS TRIGGER AS $$
  BEGIN
    INSERT INTO public.car (owner_id, name, longitude, latitude)
    VALUES(new.id, 'Name your car', 10.7259637, 59.9073389);
  
    RETURN NEW;
  END;
$$
LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS signup_add_car on auth.users;
CREATE TRIGGER signup_add_car
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE PROCEDURE add_car();