$categories = @{
    "residential" = @{
        client = "Mr. & Mrs. Sharma, Private Homeowners"
        size = "3,200 sq. ft."
        location = "Green Valley Estate, Sector 21, Churu"
        owner = "Private Owner"
        architect = "Residential Architect"
        h2_1 = "Modern Living Spaces"
        para_1 = "Our residential projects focus on creating comfortable, functional homes that reflect your lifestyle. From contemporary villas to traditional family homes, we design spaces where memories are made. Each project combines aesthetic appeal with practical living solutions."
        h2_2 = "Personalized Home Design"
        para_2 = "We believe every home should tell a story. Our residential designs incorporate natural light, open spaces, and sustainable materials. Whether it's a compact apartment or a sprawling bungalow, we ensure your home is a perfect blend of comfort and style."
        h2_3 = "Quality Construction"
        para_3 = "From foundation to finishing, we maintain the highest standards in residential construction. Our team ensures timely delivery, budget adherence, and superior craftsmanship. We use premium materials and modern construction techniques to build homes that last generations."
    }
    "commercial" = @{
        client = "TechCorp Solutions Pvt. Ltd."
        size = "12,500 sq. ft."
        location = "Business Park, MG Road, Churu"
        owner = "Corporate Entity"
        architect = "Commercial Architect"
        h2_1 = "Dynamic Business Spaces"
        para_1 = "Commercial architecture demands functionality, efficiency, and brand identity. We design office buildings, retail spaces, and commercial complexes that enhance productivity and customer experience. Our designs optimize space utilization while creating impressive business environments."
        h2_2 = "Strategic Space Planning"
        para_2 = "Every commercial project requires careful planning of workflow, customer flow, and operational efficiency. We create flexible spaces that can adapt to changing business needs. From modern office layouts to attractive retail storefronts, we deliver commercial excellence."
        h2_3 = "Business-Focused Design"
        para_3 = "Our commercial projects balance aesthetics with ROI. We understand that commercial spaces must attract customers, inspire employees, and represent your brand effectively. Energy efficiency, accessibility, and compliance are integral to our commercial designs."
    }
    "institutional" = @{
        client = "Churu Education Trust"
        size = "25,000 sq. ft."
        location = "Education Hub, Station Road, Churu"
        owner = "Educational Trust"
        architect = "Institutional Architect"
        h2_1 = "Learning Environments"
        para_1 = "Institutional architecture shapes how people learn, heal, and grow. We design schools, colleges, hospitals, and community centers that serve their purpose effectively. Our institutional projects prioritize accessibility, safety, and functionality while creating inspiring environments."
        h2_2 = "Community-Centered Design"
        para_2 = "Educational and healthcare facilities require specialized design considerations. We create spaces that promote learning, healing, and community engagement. Natural lighting, proper ventilation, and thoughtful circulation are key elements in our institutional designs."
        h2_3 = "Sustainable Institutions"
        para_3 = "Institutional buildings serve communities for decades. We design with longevity, low maintenance, and environmental responsibility in mind. Our projects incorporate green building practices, energy-efficient systems, and durable materials that reduce long-term operational costs."
    }
    "hospitality" = @{
        client = "Royal Heritage Hotels Group"
        size = "45,000 sq. ft."
        location = "Tourist District, NH Road, Churu"
        owner = "Hospitality Group"
        architect = "Hospitality Architect"
        h2_1 = "Guest Experience Design"
        para_1 = "Hospitality architecture creates memorable experiences. We design hotels, resorts, and restaurants that delight guests and optimize operations. Our hospitality projects balance luxury with functionality, creating spaces that guests remember and return to."
        h2_2 = "Ambiance and Comfort"
        para_2 = "Every hospitality space tells a story and creates an atmosphere. We design welcoming lobbies, comfortable guest rooms, and attractive dining areas. Attention to detail, quality finishes, and thoughtful amenities define our hospitality projects."
        h2_3 = "Operational Excellence"
        para_3 = "Successful hospitality design considers both guest experience and operational efficiency. We plan service areas, staff circulation, and back-of-house functions carefully. Our designs help hospitality businesses deliver exceptional service while maintaining profitability."
    }
    "master-plan" = @{
        client = "Churu Development Authority"
        size = "150 Acres"
        location = "New Town Development, Outer Ring Road"
        owner = "Government Authority"
        architect = "Urban Planner"
        h2_1 = "Comprehensive Planning"
        para_1 = "Master planning shapes entire communities and developments. We create comprehensive plans for residential townships, industrial parks, and mixed-use developments. Our master plans consider infrastructure, connectivity, sustainability, and future growth."
        h2_2 = "Integrated Development"
        para_2 = "Successful master plans integrate residential, commercial, recreational, and civic spaces. We design communities with proper zoning, green spaces, and infrastructure planning. Our approach ensures balanced development that enhances quality of life."
        h2_3 = "Future-Ready Communities"
        para_3 = "Master planning requires vision for decades ahead. We incorporate smart city concepts, sustainable practices, and flexible frameworks. Our plans accommodate growth while preserving environmental and cultural values, creating thriving communities for future generations."
    }
    "interiors" = @{
        client = "Elite Residences & Corporate Offices"
        size = "8,500 sq. ft."
        location = "Premium Locations Across Churu"
        owner = "Multiple Clients"
        architect = "Interior Designer"
        h2_1 = "Transformative Interiors"
        para_1 = "Interior design transforms spaces into experiences. We create residential and commercial interiors that reflect personality, enhance functionality, and inspire daily life. From concept to execution, we handle every detail of your interior transformation."
        h2_2 = "Style Meets Function"
        para_2 = "Great interiors balance beauty with practicality. We select materials, colors, furniture, and lighting that work together harmoniously. Whether contemporary, traditional, or eclectic, we create interiors that suit your taste and lifestyle perfectly."
        h2_3 = "Complete Interior Solutions"
        para_3 = "Our interior services cover space planning, furniture design, lighting design, and decor selection. We coordinate with contractors and vendors to ensure flawless execution. From luxury homes to corporate offices, we deliver interiors that exceed expectations."
    }
}

foreach ($cat in $categories.Keys) {
    $file = "c:\Users\Admin\Downloads\artchitec\listings\$cat\index.htm"
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $c = [System.Text.Encoding]::UTF8.GetString($bytes)
    $data = $categories[$cat]
    
    # Update Client
    $c = $c.Replace("Irmentrud Stella, Corporate Office Tenant", $data.client)
    
    # Update Size
    $c = $c.Replace("1,850 sq. ft.", $data.size)
    
    # Update Location
    $c = $c.Replace("22 Sunset Boulevard, Hillview, FL 33101", $data.location)
    
    # Update Owner
    $c = $c.Replace(">Investor</div>", (">" + $data.owner + "</div>"))
    
    # Update Architect
    $c = $c.Replace(">Interior Architect</div>", (">" + $data.architect + "</div>"))
    
    # Update H2 headings
    $c = $c.Replace(">Et magnis dis</h2>", (">" + $data.h2_1 + "</h2>"))
    $c = $c.Replace(">Ex sapien vitae pellentesque</h2>", (">" + $data.h2_2 + "</h2>"))
    $c = $c.Replace(">Duis convallis tempus</h2>", (">" + $data.h2_3 + "</h2>"))
    
    # Update paragraphs
    $c = $c.Replace("Nisi sodales consequat magna ante condimentum neque at. Euismod quam justo lectus commodo augue arcu dignissim. Dui felis venenatis ultrices proin libero feugiat tristique. Dolor sit amet consectetur adipiscing elit quisque faucibus. Urna tempor pulvinar vivamus fringilla lacus nec metus. Torquent per conubia nostra inceptos himenaeos orci varius.Fermentum odio phasellus non purus est efficitur laoreet. Finibus facilisis dapibus etiam interdum tortor ligula congue. Imperdiet mollis nullam volutpat porttitor ullamcorper. ", $data.para_1)
    
    $c = $c.Replace("Mauris pharetra vestibulum fusce dictum risus blandit quis. Sollicitudin erat viverra ac tincidunt nam porta elementum. Cras eleifend turpis fames primis vulputate ornare sagittis. Curabitur facilisi cubilia curae hac habitasse platea dictumst. Pretium tellus duis convallis tempus leo eu aenean. Ut hendrerit semper vel class sodales consequataptent taciti sociosqu. Donec rhoncus eros lobortis nulla molestie mattis scelerisque.", $data.para_2)
    
    $c = $c.Replace("Eros lobortis nulla molestie mattis scelerisque maximus eget. Consequat magna ante condimentum neque at luctus nibh. Justo lectus commodo augue arcu dignissim velit aliquam. Venenatis ultrices proin libero feugiat tristique accumsan maecenas.Amet consectetur adipiscing elit quisque faucibus ex sapien. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Conubia nostra inceptos himenaeos orci varius natoque penatibus. ", $data.para_3)
    
    $newBytes = [System.Text.Encoding]::UTF8.GetBytes($c)
    [System.IO.File]::WriteAllBytes($file, $newBytes)
    Write-Host "Updated: $cat"
}
Write-Host "All content customized"
