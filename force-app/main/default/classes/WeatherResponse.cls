public class WeatherResponse {

    public String address;
	public class Weather {
		public String description {get;set;} 
	}
	
	public class Hourly {
		public List<Weather> weather {get;set;} 
    }
	
	public class Daily {
		public Temp temp {get;set;} 
		public List<Weather> weather {get;set;} 
	}
	
	public class Temp {
		public Double day {get;set;} 
		public Double min {get;set;} 
		public Double max {get;set;} 
		public Double night {get;set;} 
		public Double eve {get;set;} 
		public Double morn {get;set;} 
	}
	
	public Decimal lat {get;set;} 
	public Decimal lon {get;set;} 
	public Current current {get;set;} 
	
	public class Current {
		public Double temp {get;set;} 
		public List<Weather> weather {get;set;} 
	}
}