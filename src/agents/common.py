import os
import sys
from openai import OpenAI
from dotenv import load_dotenv
import json

try:
    import tools
except ImportError:
    from agents import tools

load_dotenv()


def get_llm_client():
    api_key = os.environ.get("OPENAI_API_KEY")
    base_url = os.environ.get("OPENAI_BASE_URL")
    args = {}
    if api_key:
        args["api_key"] = api_key
    if base_url:
        args["base_url"] = base_url
    if not api_key:
        print("Error: OPENAI_API_KEY environment variable is not set.")
        sys.exit(1)
    return OpenAI(**args)


def call_llm(
    system_prompt: str,
    user_prompt: str | list,
    model: str = "gpt-5.2",
    use_tools: bool = False,
) -> str:
    """
    Calls the LLM with the given prompts and returns the content.
    If use_tools is True, it enables the agent to use defined tools.
    """
    client = get_llm_client()
    messages = [
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": user_prompt},
    ]

    tool_choice = "auto" if use_tools else None
    tool_defs = tools.TOOLS_DEF if use_tools else None

    try:
        while True:
            response = client.chat.completions.create(
                model=model,
                messages=messages,
                tools=tool_defs,
                tool_choice=tool_choice,
                temperature=0.7,
            )

            message = response.choices[0].message

            if message.tool_calls:
                # Append the assistant's message with tool calls
                messages.append(message)

                for tool_call in message.tool_calls:
                    func_name = tool_call.function.name
                    args = json.loads(tool_call.function.arguments)

                    print(f"Tool Call: {func_name}({args})")

                    if func_name in tools.AVAILABLE_TOOLS:
                        result = tools.AVAILABLE_TOOLS[func_name](**args)
                    else:
                        result = f"Error: Tool {func_name} not found."

                    messages.append(
                        {
                            "role": "tool",
                            "tool_call_id": tool_call.id,
                            "content": str(result),
                        }
                    )
            else:
                return message.content.strip()

    except Exception as e:
        print(f"Error calling LLM: {e}")
        # Return empty string or re-raise depending on strictness.
        # Since this is a library function, exiting might be harsh but consistent with previous behavior.
        sys.exit(1)
