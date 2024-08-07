using Documenter

makedocs(
    sitename = "GCP Decomposition Software Contributions",
    format = Documenter.HTML()
)

deploydocs(
    repo = "https://github.com/bakergg/REU-Showcase-2024.git",  # Replace with your GitHub repo
    branch = "gh-pages",
    target = "build"
)