import { Configuration, OpenAIApi } from "openai";

export const handler = async(e) => {
    
    var body = JSON.parse( e.body );
    console.log( body );
    
    
    const configuration = new Configuration({
      apiKey: 'CHATGPT-API-KEY',
    });
    const openai = new OpenAIApi(configuration);
    
    var prompt = body.data[0][1]; 
    console.log(`Prompt: ${prompt}`);
  
    var resp = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: prompt,
      temperature: 0.7,
      max_tokens: 2500,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0,
    })


    var r = resp.data.choices[0].text.replace(/\n/g,"  \n ");
    // the answer for Snowflake needs specific format
    // this way if you send multiple rows to the external function snowflake can tie the two together
    var answer = {};
    answer.data = [];
    answer.data[0] = [0, r];
    
    console.log(answer)
    
    // RETURN REPONSE
    const response = {
        statusCode: 200,
        body: JSON.stringify(answer)
    };
    
    return response;
};
