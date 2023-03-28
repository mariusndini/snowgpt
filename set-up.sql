// BE ACCOUNT ADMIN
use role accountadmin;

// 1 - create integration
//create external function integration
create or replace api integration GPT_INTEGRATION
  api_provider = aws_api_gateway
  api_aws_role_arn = 'arn:aws:iam::XYZ'
  api_allowed_prefixes = ('https://XYZ.execute-api.us-west-2.amazonaws.com')
  enabled = true;

//GET THE INGEGRATION USER FROM SNOWFLAKE
describe INTEGRATION GPT_INTEGRATION; 

//CREATE DB.SCHEMA WHERE TO PUT EXTERNAL FUNCTION
CREATE DATABASE SNOWGPT;
CREATE SCHEMA GPT;

// 2 - create the function itself
// CREATE THE FUNCTION AND THE RETURN OBJECT
create or replace external function SNOWGPT.GPT.PROMPT(PROMPT STRING)
    returns VARIANT
    api_integration = GPT_INTEGRATION
    as 'https://XYZ.execute-api.us-west-2.amazonaws.com/dev/gpt';


// 3 - CALL THE FUNCTION
// TEST TO SEE IF THE FUNCTION WORKS W/ A PROPER PROMPT
select SNOWGPT.GPT.PROMPT('write me a poem about candy');





