import openai

# Initialize OpenAI with your API key
openai.api_key = 'YOUR_OPENAI_API_KEY'

# Function to get fashion description from Gemini API
def get_fashion_description(description):
    response = openai.Completion.create(
        engine="text-davinci-003",
        prompt=description,
        max_tokens=150
    )
    
    if response and 'choices' in response:
        text = response['choices'][0]['text'].strip()
        return text
    else:
        print("Failed to get a description.")
        return None

# Main chatbot loop
def fashion_chatbot():
    print("Welcome to the Fashion Chatbot!")
    
    while True:
        user_input = input("Describe the fashion item you want to see (or type 'exit' to quit): ")
        
        if user_input.lower() == 'exit':
            break
        
        description = get_fashion_description(user_input)
        
        if description:
            print("Here is the fashion description:")
            print(description)
            print("\nTo visualize this image, you can try using a text-to-image generator tool like DALL-E 2 or Midjourney.")
        else:
            print("Sorry, I couldn't generate a description for that request.")

if __name__ == "__main__":
    fashion_chatbot()
