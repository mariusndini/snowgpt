# Import python packages
import streamlit as st
from snowflake.snowpark.context import get_active_session

# Write directly to the app
st.title("Streamlit App Using ChatGPT :balloon:")
st.write(
    """This example uses Snowflake **External Functions** to connect to
    **ChatGPT**.
    """
)

# Get the current credentials
session = get_active_session()

text_input = st.text_area(
        "Enter Prompt 👇",
        placeholder="Write a Poem about SQL.",
    )

if st.button('GO! :brain:'):
    query = f""" select SNOWGPT.GPT.PROMPT('{text_input}') """
    st.write("**Running Query:** ", query)
    
    gpt_data = session.sql(query).to_pandas()
    output = str( gpt_data.iloc[0,0] ).replace("\\n", "\n")[1:-1]
    st.markdown( f"""{output}""" )

    



